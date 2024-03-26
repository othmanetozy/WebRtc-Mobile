const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

async function server() {
  const app = express();
  const httpServer = http.createServer(app);
  const io = new Server(httpServer, { transports: ['websocket'] });
  const roomName = 'test';

  // Route pour la racine
  app.get('/', (req, res) => {
    res.send('Welcome to my Socket.IO server');
  });

  io.on('connection', (socket) => {
    console.log('Client connected');

    socket.on('join', () => {
      console.log("Received 'join' event");
      socket.join(roomName);
      console.log("Joined room: " + roomName);
      socket.to(roomName).emit('joined');
      console.log("Emitted 'joined' event to room: " + roomName);
    });

    socket.on('offer', (offer) => {
      socket.to(roomName).emit('offer', offer);
    });

    socket.on('answer', (answer) => {
      socket.to(roomName).emit('answer', answer);
    });

    socket.on('ice', (ice) => {
      socket.to(roomName).emit('ice', ice);
    });
    socket.on('disconnect', () => {
      console.log('Client disconnected');
      socket.to(roomName).emit('user disconnected');
    });
  });

  httpServer.listen(3000, () => {
    console.log('Server is running on http://localhost:3000');
  });
}

server();
