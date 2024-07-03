const Book = require("../models/bookModel")

const addBook = async(req, res) => {
    const {title, subtitle, description} = req.body

}

module.exports = {
    addBook, getBook,
}