const User = require("../models/userModel");
const cloudinary = require("cloudinary");
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
// const validate = require("deep-email-validator")


const signUp = async (req, res) => {
    console.log(req.body);
    const { fullName, email, userName, phoneNumber, password} = req.body;
    let image = req.files && req.files.image;

    // Check if image is not provided or undefined, set it to an empty string
    if (!image) {
        image = { path: '' }; // or use any default value that indicates no image
    } else if (!image.path) {
        // Handle case where req.files.image exists but does not have path (unexpected case)
        console.error("Uploaded file does not have 'path' property:", image);
        return res.status(400).json({
            success: false,
            message: "Uploaded file is invalid"
        });
    }

    if (!fullName || !email || !userName || !phoneNumber || !password) {
        return res.status(400).json({
            success: false,
            message: "Please enter all fields"
        });
    }
    // if (password !== confirmPassword) {
    //     return res.status(400).json({
    //         success: false,
    //         message: "Password did not Match"
    //     });
    // }
    try {
        // Uploading image to cloudinary if image path is provided
        let uploadedImage = { secure_url: '' }; // default empty string for image URL

        if (image.path) {
            uploadedImage = await cloudinary.v2.uploader.upload(
                image.path,
                {
                    folder: "user",
                    crop: "scale"
                });
        }

        const userExist = await User.findOne({ email: email });
        if (userExist) {
            return res.status(400).json({
                success: false,
                message: "User Already Exist"
            });
        }
        const userNameExist = await User.findOne({ userName: userName });
        if (userNameExist) {
            return res.status(400).json({
                success: false,
                message: "UserName already taken"
            });
        }
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt)
        const userData = new User({
            fullName: fullName,
            email: email,
            userName: userName,
            phoneNumber: phoneNumber,
            password: hashedPassword,
            image: uploadedImage.secure_url, // Use the updated image value
            isAdmin: false
        });
        await userData.save();
        return res.status(200).json({
            success: true,
            message: "User Created Successfully",
            userData,
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            success: false,
            message: "Internal Server Error"
        });
    }
};


// const signUp = async (req, res) => {
//     console.log(req.body);
//     const { fullName, email, userName, phoneNumber, password, "confirm-password": confirmpassword } = req.body;
//     const { image } = req.files;

//     if (!fullName || !email || !userName || !phoneNumber || !password || !confirmpassword) {
//         return res.status(400).json({
//             success: false,
//             message: "Please enter all fields"
//         });
//     }
//     if (password !== confirmpassword) {
//         return res.status(400).json({
//             success: false,
//             message: "Password did not Match"
//         });
//     }
//     try {
//         // Uploading image to cloudinary
//         const uploadedImage = await cloudinary.v2.uploader.upload(
//             image.path,
//             {
//                 folder: "user",
//                 crop: "scale"
//             });
//         const userExist = await User.findOne({ email: email });
//         if (userExist) {
//             return res.status(400).json({
//                 success: false,
//                 message: "User Already Exist"
//             });
//         }
//         const userNameExist = await User.findOne({ userName: userName });
//         if (userNameExist) {
//             return res.status(400).json({
//                 success: false,
//                 message: "UserName already taken"
//             });
//         }
//         const salt = await bcrypt.genSalt(10);
//         const hashedPassword = await bcrypt.hash(password, salt)
//         const userData = new User({
//             fullName: fullName,
//             email: email,
//             userName: userName,
//             phoneNumber: phoneNumber,
//             password: hashedPassword,
//             image: uploadedImage.secure_url,
//             isAdmin: false
//         });
//         await userData.save();
//         return res.status(200).json({
//             success: true,
//             message: "User Created Successfully",
//             userData,
//         });
//     } catch (error) {
//         console.error(error);
//         return res.status(500).json({
//             success: false,
//             message: "Internal Server Error"
//         });
//     }
// };

const signin = async (req, res) => {
    const { userName, password } = req.body
    if (!userName || !password) {
        return res.status(400).json({
            success: false,
            message: "Please Enter all fields"
        })
    }
    try {
        const userData = await User.findOne({ userName: userName })
        if (!userData) {
            return res.status(400).json({
                success: false,
                message: "Invalid Username"
            })
        }
        const checkDatabasePassowrd = userData.password
        const isMatched = await bcrypt.compare(password, checkDatabasePassowrd)
        if (!isMatched) {
            return res.status(400).json({
                success: false,
                message: "Invalid Password"
            })
        }
        const payload = {
            id: userData._id,
            userName: userData.userName,
            email: userData.email,
            fullName: userData.fullName,
            phoneNumber: userData.phoneNumber,
            selectedCourse: userData.selectedCourse,
            image: userData.image
        };
        const token = jwt.sign( payload, process.env.JWT_SECRET, {expiresIn: "6hr"})
        res.status(201).json({
            success: true,
            token: token,
            userData,
            message: "Login Successfully"
        })
    } catch (error) {
        console.log(error)
        return res.status(400).json({
            success: false,
            message: "Internal Server Error"
        })
    }

}

//User Profile 
const userProfile = async (req, res) => {
    try {
        const user = await User.findById(req.params.id)
        if (!user) {
            return res.status(400).json({
                success: false,
                message: "User Not Found"
            })
        }
        return res.status(201).json({
            success: true,
            user
        })
    } catch (error) {
        console.log(error)
        return res.status(400).json({
            success: false,
            message: "Inernal Server Error"
        })
    }
}

module.exports = {
    signUp, signin, userProfile
};
