// script.js
const logsContainer = document.getElementById('logs');

function appendLog(message) {
    const logItem = document.createElement('div');
    logItem.textContent = message;
    logsContainer.appendChild(logItem);
    logsContainer.scrollTop = logsContainer.scrollHeight;
}

// WebSocket connection
const socket = new WebSocket('ws://localhost/ws');

socket.onopen = function(event) {
    appendLog('WebSocket connection established.');
};

socket.onmessage = function(event) {
    const message = event.data;
    appendLog(message);
};

socket.onclose = function(event) {
    appendLog('WebSocket connection closed.');
};

socket.onerror = function(error) {
    appendLog('WebSocket error: ' + error);
};
