const mongoose = require('mongoose')


const userSchema = new mongoose.Schema({
    firstName: {
        type: String,
        required: true,
    },
    lastName: {
        type: String,
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    password: {
        type: String,
        // required:true,
    },
    numTel: {
        type: Number,
        // required:true,
    },
    lat: {
        type: String,
        // required:true,
    },
    lng: {
        type: String,
        // required:true,
    },
    admin: {
        type: Boolean,
        required: true,
    },
    profilePicture: {
        type: String,
    },
}, { timestamps: true });

const User = mongoose.model('User', userSchema);

module.exports = User