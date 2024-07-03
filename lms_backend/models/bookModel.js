const mongoose = require("mongoose")
const bookSchema = new mongoose.Schema({
    title: {
        type: String,
    },
    subtitle: {
        type: String,
    },
    description: {
        type: String
    },
    image: {
        type: String,
        require: false
    },
    course: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Course",
        required: true
    }
})

const Book = mongoose.model('Book', bookSchema)
module.exports = Book;