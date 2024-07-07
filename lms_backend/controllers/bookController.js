const Book = require("../models/bookModel");
const User = require("../models/userModel");
const cloudinary = require("cloudinary");

const createBook = async (req, res) => {
    const { title, subtitle, description, courseId, image, level} = req.body;

    if (!title || !courseId || !level) {
        return res.status(400).json({ success: false, message: "Title, Course ID and Level are required" });
    }
    
    //validating Level
    const validLevels = ["Beginner", "Easy", "Medium", "Hard", "Advance"];
    if(!validLevels){
        
        return res.status(400).json({ success: false, message: "Invalid Level" });
    }

    try {
        let imageUrl;

        if (typeof image === 'string' && image.startsWith('http')) {
            // If image is a URL
            imageUrl = image;
        } else if (req.files && req.files.image) {
            // If image is a file, upload to Cloudinary
            const uploadedImage = await cloudinary.uploader.upload(req.files.image.path, {
                folder: "course",
                crop: "scale"
            });
            imageUrl = uploadedImage.secure_url;
        }

        // Check if book already exists
        const bookExist = await Book.findOne({ title });
        if (bookExist) {
            return res.status(400).json({
                success: false,
                message: "Book Already Exists",
            });
        }

        // Create a new book
        const newBook = new Book({
            title,
            subtitle,
            description,
            image: imageUrl || '', 
            course: courseId,
            level
        });

        // Save the book to the database
        await newBook.save();

        res.status(201).json({ success: true, book: newBook, message: "Book Created Successfully" });
    } catch (error) {
        console.log(`Error creating book: ${error}`);
        res.status(500).json({ success: false, message: error.message });
    }
};

const getBookbyLevel = async (req, res) => {
    const { level, id } = req.params; 

    const validLevels = ["Beginner", "Easy", "Medium", "Hard", "Advance"];
    if (!validLevels.includes(level)) {
        return res.status(400).json({ success: false, message: "Invalid Level" });
    }

    try {
        // Fetch user data to get selected course IDs
        const userData = await User.findById(id).populate('selectedCourse');
        if (!userData) {
            return res.status(404).json({ success: false, message: "User not found" });
        }

        // Extract course IDs from user data
        const courseIds = userData.selectedCourse.map(course => course._id);

        // Fetch books according to the level and course IDs
        const books = await Book.find({ level, course: { $in: courseIds } });

        if (books.length === 0) {
            return res.status(404).json({ success: false, message: `No books found for level '${level}' and user's courses` });
        }

        res.status(200).json({ success: true, books });
    } catch (error) {
        console.log(`Error fetching books by level: ${error}`);
        res.status(500).json({ success: false, message: error.message });
    }
};


module.exports = {
    createBook, getBookbyLevel
};
