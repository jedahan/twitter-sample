# we want to read a twitter stream later
Writable = require('stream').Writable
handleStream = Writable()

handleStream._write = (chunk, enc, next) ->
  for socket in connectedSockets
      socket.emit 'tweet', chunk.toString()
  next()

# twitter
twitter = require 'mtwitter'
credentials = require './credentials.json'
t = new twitter credentials

keywords = 'smilesurfer'

# server
restify = require 'restify'
server = restify.createServer()

# socket.io
socketio = require 'socket.io'
io = socketio.listen server
connectedSockets = []

io.sockets.on 'connection', (socket) ->
  connectedSockets.push socket

io.set 'log level', 1

# cors proxy and body parser
server.use restify.bodyParser()
server.use restify.fullResponse() # set CORS, eTag, other common headers

# attract screen
server.get /\/*$/, restify.serveStatic directory: './public', default: 'index.html'

server.listen (process.env.PORT or 8080), ->
  content = {track: keywords}
  t.stream.raw(
    'POST',
    'https://stream.twitter.com/1.1/statuses/filter.json',
    {content},
    handleStream
  )
  console.info "[%s] #{server.name} listening at #{server.url}", process.pid