const express = require('express');
const router = express.Router();
const userDataController = require("../controllers/userData.conroller");
const uploadFiles = require("../../config/multer");


router.patch('/upload-picture', uploadFiles('ProfilePic').single('profileImage'), userDataController.changePicture);
router.patch('/edit-data', userDataController.changeOtherData);





module.exports = router;