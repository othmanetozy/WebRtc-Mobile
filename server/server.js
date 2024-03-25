const app = require('express')();
const {Server} = require('socket.io');

async function server(){
    const http = require('http').createServer(app);
    const io = new Server(http, {transports: ['websocket']});
    const roomName = 'test';
    io.on('connection', (socket) => {
       
        socket.on('join', () =>{
         socket.join(roomName);
         socket.to(roomName).emit('joined');
       
        });
      
      
       socket.on('offer', (offer) => {
           socket.to(roomName).emit('offer', offer);
        });
      
        socket.on('answer', (answer) => {
            socket.to(roomName).emit('answer', answer);
        });
      
        socket.on('ICE', (ice) => {
            socket.to(roomName).emit('ICE', ice);
        });

    });
    http.listen(3001, () => console.log('serveur est ouvert'));
}

server();