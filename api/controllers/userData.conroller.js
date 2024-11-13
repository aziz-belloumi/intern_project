const User = require('../model/user.model');
const jwt = require('jsonwebtoken');
const fs = require('fs');
const path = require('path');


const changePicture = async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ error: 'No file uploaded' });
        }
        const email = req.body.email; // Assuming you're sending the user's ID in the request body
        const filename = req.file.filename;
        const profilePicture = `/public/ProfilePic/${filename}`;

        const user = await User.findOne({ email: email });
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }

        if (user.profilePicture) {
            const oldProfilePicturePath = path.join(process.cwd(), user.profilePicture); // Absolute path of the old picture

            // Check if the old file exists and delete it
            if (fs.existsSync(oldProfilePicturePath)) {
                fs.unlinkSync(oldProfilePicturePath); // Delete the file
            }
        }

        // Update the user's profile picture in the database
        const updatedUser = await User.findOneAndUpdate(
            { email: email },
            { profilePicture: profilePicture },
            { new: true } // Return the updated user
        );
        const { password: password, ...rest } = updatedUser._doc;
        const token = jwt.sign(rest, process.env.JWT_SECRET, { expiresIn: "1h" });
        res.status(200).json({ message: 'File uploaded successfully', token: token, profilePicture: profilePicture });
    } catch (error) {
        res.status(500).json({ error: 'An error occurred while updating the profile picture' });
    }
}

const changeOtherData = async (req, res) => {
    const { oldEmail, newEmail, firstName, lastName, numTel } = req.body;
    console.log(oldEmail, newEmail, firstName, lastName, numTel);
    try {
        const updatedUser = await User.findOneAndUpdate(
            { email: oldEmail },
            {
                $set: {
                    email: newEmail,
                    firstName: firstName,
                    lastName: lastName,
                    numTel: numTel
                }
            },
            { new: true }
        );

        if (!updatedUser) {
            return res.status(404).json({ message: 'User not found' });
        }
        const { password: password, ...rest } = updatedUser._doc;
        const token = jwt.sign(rest, process.env.JWT_SECRET, { expiresIn: "1h" });
        return res.status(200).json({ message: 'User updated successfully', token: token });
    } catch (error) {
        return res.status(500).json({ message: 'Error updating user' });
    }
}




module.exports = {
    changePicture,
    changeOtherData,
};



