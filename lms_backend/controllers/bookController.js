const Book = require("../models/bookModel");
const cloudinary = require("cloudinary");

const createBook = async (req, res) => {
    const { title, subtitle, description, courseId, image } = req.body;

    if (!title || !courseId) {
        return res.status(400).json({ success: false, message: "Title and Course ID are required" });
    }

    try {
        let imageUrl;
        if (image) {
            // Check if image is a URL
            if (image.startsWith('http')) {
                imageUrl = image;
            } else {
                // Upload image to Cloudinary
                const uploadedImage = await cloudinary.uploader.upload(image.path, {
                    folder: "book",
                    crop: "scale",
                });
                imageUrl = uploadedImage.secure_url;
            }
        }

        // Check if book already exists
        const bookExist = await Book.findOne({ title });
        if (bookExist) {
            return res.status(400).json({
                success: false,
                message: "Book Already Exist",
            });
        }

        // Create a new book
        const newBook = new Book({
            title,
            subtitle,
            description,
            image: imageUrl,
            course: courseId,
        });

        // Save the book to the database
        await newBook.save();

        res.status(201).json({ success: true, book: newBook, message: "Book Created Successfully" });
    } catch (error) {
        console.log(`Error creating book: ${error}`);
        res.status(500).json({ success: false, message: error.message });
    }
};

module.exports = {
    createBook,
};
