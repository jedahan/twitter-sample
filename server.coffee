# twitter
twit = require 'twit'
credentials = require './credentials.json'
t = new twit credentials
keywords = 'smilesurfer'

# server
restify = require 'restify'
server = restify.createServer()

server.use restify.bodyParser()
server.use restify.fullResponse()
server.get /\/*$/, restify.serveStatic directory: './public', default: 'index.html'

# socket.io
socketio = require 'socket.io'
io = socketio.listen server
connectedSockets = []

io.sockets.on 'connection', (socket) ->
  connectedSockets.push socket

io.set 'log level', 1

server.listen (process.env.PORT or 5200), ->
  stream = t.stream 'statuses/filter', { track: keywords }

  stream.on 'tweet', (tweet) ->
    for socket in connectedSockets
      socket.emit 'tweet', tweet

  console.info "[%s] #{server.name} listening at #{server.url}", process.pid