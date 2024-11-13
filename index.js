// imports 
const config = require("./config/environment");
const { app, io, server } = require("./config/express");
const Chat = require('./api/model/chat.model');
const express = require('express');
const mongoose = require('mongoose');

///routes 
const authRoutes = require('./api/routes/auth.route');
const userDataRoutes = require('./api/routes/userData.route');
const chatRoutes = require('./api/routes/chat.route');
const propertyRoutes = require('./api/routes/property.route');

// Load database config
const Database = require('./config/database');

const path = require('path');

// connect to mongo db
Database.connect();

io.on('connection', (socket) => {

  console.log('User connected');

  socket.on("wait_for_message", async (id) => {
    console.log("waiting for comming messages in the mai  page")
    const sourceId = new mongoose.Types.ObjectId(id.sourceId);
    console.log(sourceId);
    socket.join(sourceId.toString());
  });


  socket.on("start_conversation", async (id) => {
    console.log("§§§§§§§ §§§§§§§§§§§§§§§§§§§§§§ start conversation");

    const sourceId = new mongoose.Types.ObjectId(id.sourceId);
    const destinationId = new mongoose.Types.ObjectId(id.destinationId);

    if (!sourceId || !destinationId) {
      console.log('Missing sourceId or destinationId');
      return;
    }

    let chat = await Chat.findOne({ participants: { $all: [sourceId, destinationId] } });

    if (!chat) {
      chat = new Chat({
        participants: [sourceId, destinationId],
        messages: []
      });

      await chat.save();
    }
  });

  socket.on("message", async (msg) => {

    const sourceId = new mongoose.Types.ObjectId(msg.sourceId);
    const destinationId = new mongoose.Types.ObjectId(msg.destinationId);

    let chat = await Chat.findOne({ participants: { $all: [sourceId, destinationId] } });
    const newMessage = {
      sender: sourceId.toString(),
      receiver: destinationId.toString(),
      message: msg.message,
      isRead: false,
      timestamp: new Date()
    };

    // Add the message to the chat
    if (!chat) {
      chat = new Chat({
        participants: [sourceId, destinationId],
        messages: [],
      });
    }
    console.log("the new message is : ", newMessage);
    chat.messages.push(newMessage);
    await chat.save();
    io.to(destinationId.toString()).emit("message", newMessage);
  });
  socket.on("disconnect", () => {
    console.log('User is disconnected');
  });

});

server.listen(config.port, () => {
  console.log(`server started on port ${config.port} (${config.env})`);
});


app.use("/api/auth", authRoutes);
app.use("/api/userData", userDataRoutes);
app.use("/api/chat", chatRoutes);
app.use("/api/properties", propertyRoutes);


// Error handling middleware
app.use((err, req, res, next) => {
  const statusCode = err.statusCode || 500;
  const message = err.message || 'Internal Server Error';
  return res.status(statusCode).json({
    success: false,
    message,
    statusCode
  });
});

console.log(config.port);

module.exports = app;