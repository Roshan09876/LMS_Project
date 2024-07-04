const express = require('express');
const router = express.Router();
const BookController = require('../controllers/bookController');
const upload = require('../middleware/upload');

// Route to create a new book
router.post('/createbook', BookController.createBook);

module.exports = router;
