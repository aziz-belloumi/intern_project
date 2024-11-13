const authController = require('../controllers/auth.controller');
const express = require('express')
const router = express.Router()




router.post('/signup', authController.signup)
router.post('/signin', authController.signin)
router.post('/google', authController.google)
router.post('/forgot-password', authController.forgotpassword)
router.post('/verification', authController.verifyCode)
router.post('/reset-password', authController.resetPassword)
router.post('/facebook', authController.facebook)

module.exports = router;













