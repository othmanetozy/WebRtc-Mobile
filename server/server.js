const express = require('express');
const http = require('http');
const { Server } = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = new Server(server, { transports: ['websocket'] });

const rooms = {}; // Définissez une variable pour stocker les salles

// Route pour la racine
app.get('/', (req, res) => {
  res.send('Welcome to my Socket.IO server');
});

io.on('connection', socket => {
  console.log(`Utilisateur connecté ${socket.id}`);

  // Logique pour gérer la création d'une nouvelle salle
  socket.on('create-room', roomId => {
    if (!rooms[roomId]) {
      rooms[roomId] = {
        membres: [socket.id],
      };
      socket.emit('room-created', roomId);
      console.log(`Pièce créée : ${roomId}`);
    } else {
      // La pièce existe déjà
      socket.emit('room-exists');
    }
  });

  // Logique pour gérer l'adhésion à une salle existante
  socket.on('join-room', (roomId, requesterUserId) => {
    const room = rooms[roomId];
    if (room && room.membres.length === 1) {
      // La salle est disponible
      room.membres.push(requesterUserId);
      console.log(`Utilisateur ${requesterUserId} a rejoint la salle ${roomId}`);
      // Envoyer un message au propriétaire de la salle
      socket.to(room.membres[0]).emit('join-request', requesterUserId);
    } else {
      // La salle est pleine ou n'existe pas
      socket.emit('room-unavailable');
    }
  });

  // Logique pour gérer les offres et les réponses
  socket.on('offer-request', data => {
    const { fromOffer, to } = data;
    console.log(`Transfert de la demande d'offre à : ${to}`);
    socket.to(to).emit('offer-request', { from: socket.id, offer: fromOffer });
  });

  socket.on('offer-response', data => {
    const { response, to } = data;
    console.log(`Transfert de la réponse de l'offre à : ${to}`);
    socket.to(to).emit('offer-response', { from: socket.id, response: response });
  });

  // Logique pour gérer les mises à jour des pairs
  socket.on('peer-update', data => {
    const { candidate, to } = data;
    console.log("Mise à jour du pair");
    socket.to(to).emit('peer-update', { from: socket.id, candidate: candidate });
  });

  // Logique pour gérer la déconnexion de l'utilisateur
  socket.on('disconnect', () => {
    console.log('Utilisateur déconnecté :', socket.id);
    // Gérer la déconnexion de l'utilisateur, quitter les salles, etc.
  });
});

server.listen(3000, () => {
  console.log('Server is running on port 3000');
});
