const mongoose = require('mongoose');
const Chat = require('../model/chat.model');
const User = require('../model/user.model');

const getPreviousMessages = async (req, res) => {

    const sourceId = req.query.sourceId;
    const destinationId = req.query.destinationId;


    if (!sourceId || !destinationId) {
        return res.status(400).json({ error: 'Both sourceId and destinationId are required' });
    }

    try {
        const sourceObjectId = new mongoose.Types.ObjectId(sourceId);
        const destinationObjectId = new mongoose.Types.ObjectId(destinationId);

        // Find the chat where both users are participants
        const chat = await Chat.findOne({
            participants: { $all: [sourceObjectId, destinationObjectId] }
        }).populate('participants', 'name'); // Populate the participants to retrieve user details if needed

        if (!chat || !chat.messages) {
            return res.status(200).json([]);
        }
        return res.status(200).json(chat.messages);
    }
    catch (error) {
        return res.status(500).json({ error: 'An error occurred while fetching messages' });
    }
}

const getUsersWithLastMessages = async (req, res) => {
    try {
        const userId = req.query.userId;

        // Find all chats where the user is a participant
        const chats = await Chat.find({ participants: userId })
            .populate('participants', 'firstName profilePicture') // Populate participants to get user details
            .select('messages participants')
            .exec();

        // Create an array to store the results
        const usersWithLastMessages = [];

        // Loop through chats and gather the last message per participant
        chats.forEach(chat => {
            chat.messages.forEach(message => {
                const otherParticipant = chat.participants.find(participant => participant._id.toString() !== userId);
                if (otherParticipant) {
                    // Check if this user is already in the result array
                    const existingUserIndex = usersWithLastMessages.findIndex(user => user._id === otherParticipant._id.toString());

                    // If user exists, compare timestamps and update if the current message is more recent
                    if (existingUserIndex !== -1) {
                        const existingUser = usersWithLastMessages[existingUserIndex];
                        if (new Date(existingUser.timestamp) < new Date(message.timestamp)) {
                            usersWithLastMessages[existingUserIndex] = {
                                _id: otherParticipant._id.toString(),
                                firstName: otherParticipant.firstName,
                                profilePicture: otherParticipant.profilePicture,
                                message: message.message,
                                timestamp: message.timestamp,
                                isRead: message.isRead,
                                sender: message.sender,
                                receiver: message.receiver
                            };
                        }
                    } else {
                        // If user doesn't exist in the result array, add them
                        usersWithLastMessages.push({
                            _id: otherParticipant._id.toString(),
                            firstName: otherParticipant.firstName,
                            profilePicture: otherParticipant.profilePicture,
                            message: message.message,
                            timestamp: message.timestamp,
                            isRead: message.isRead,
                            sender: message.sender,
                            receiver: message.receiver
                        });
                    }
                }
            });
        });

        // Sort by timestamp to ensure most recent messages are first
        usersWithLastMessages.sort((a, b) => new Date(b.timestamp) - new Date(a.timestamp));
        res.status(200).json(usersWithLastMessages);
    } catch (error) {
        res.status(500).json({ success: false, message: 'Failed to fetch users and last messages' });
    }
};




const searchForUsers = async (req, res) => {
    try {
        const searchTerm = req.query.q;
        const sourceId = req.query.sourceId;

        if (!searchTerm && searchTerm != "") {
            return res.status(400).json({ message: 'Search term is required' });
        }

        const users = await User.find({
            firstName: { $regex: searchTerm, $options: 'i' }, // 'i' for case-insensitive search 
            _id: { $ne: sourceId }
        },
            {
                email: 0,
                admin: 0,
                lastName: 0,
                numtel: 0,
                lat: 0,
                lat: 0,
                lng: 0,
                password: 0,
                createdAt: 0,
                updatedAt: 0,
                __v: 0
            }
        );
        return res.status(200).json(users);
    }
    catch (err) {
        return res.status(500).json({ message: err.message });
    }
};











module.exports = {
    getPreviousMessages,
    getUsersWithLastMessages,
    searchForUsers
};