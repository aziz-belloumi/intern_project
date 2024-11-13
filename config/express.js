const express = require('express');
const cors = require('cors');
const http = require('http');

const app = express();
const server = http.createServer(app);

const io = require("socket.io")(server, {
    cors: {
        origin: "*"
    }
});

// middleware
app.use(express.json());
app.use('/public', express.static('public'))
app.use(cors());

// app.use('/api', routes);

module.exports = {
    app,
    io,
    server
};
