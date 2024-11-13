const express = require('express');
const router = express.Router();
const chatController = require("../controllers/chat.controller");


router.get('/messages', chatController.getPreviousMessages);
router.get('/last-messages', chatController.getUsersWithLastMessages);
router.get('/search-for-users', chatController.searchForUsers);

module.exports = router;