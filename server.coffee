# server
restify = require 'restify'
server = restify.createServer()

# socket.io
socketio = require 'socket.io'
io = socketio.listen server
connectedSockets = []
io.sockets.on 'connection', (socket) -> connectedSockets.push socket

# twitter
twitter = require 'ntwitter'
credentials = require './credentials.json'
t = new twitter credentials

t.stream 'user', {track:'god'}, (stream) ->
  stream.on 'data', (data) ->
    for socket in connectedSockets
      socket.emit 'tweet', data

# cors proxy and body parser
server.use restify.bodyParser()
server.use restify.fullResponse() # set CORS, eTag, other common headers

# attract screen
server.get /\/*$/, restify.serveStatic directory: './public', default: 'index.html'

server.listen (process.env.PORT or 8080), ->
  console.info "[%s] #{server.name} listening at #{server.url}", process.pid