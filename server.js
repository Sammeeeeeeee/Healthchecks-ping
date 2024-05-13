// server.js
const express = require('express');
const http = require('http');
const WebSocket = require('ws');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server, path: '/ws' });

wss.on('connection', function connection(ws) {
    console.log('Client connected.');

    // Example: Sending message every second
    const interval = setInterval(() => {
        const message = 'Hello from server at ' + new Date();
        ws.send(message);
    }, 1000);

    ws.on('close', function close() {
        console.log('Client disconnected.');
        clearInterval(interval);
    });
});

server.listen(3000, function() {
    console.log('Server listening on port 3000.');
});
