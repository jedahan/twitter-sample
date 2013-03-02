keywords = 'god,evil,love,hate,hell,good,bad,devil,pray,dios,mal,amor,odio,infierno,bien,maldad,diablo,rezar'

# server
restify = require 'restify'
server = restify.createServer()

# socket.io
socketio = require 'socket.io'
io = socketio.listen server
connectedSockets = []
io.sockets.on 'connection', (socket) -> connectedSockets.push socket
io.set 'log level', 1

# twitter
twitter = require 'ntwitter'
credentials = require './credentials.json'
t = new twitter credentials

handleStream = ->
  for socket in connectedSockets
    socket.on 'tweet', (data) ->
      reply = JSON.parse(data)
      t.updateStatus, "@#{reply.username} #{reply.message}", {in_reply_to_status_id: reply.status_id}, (err, reply) ->
        console.error err if err
        res.send reply

  t.stream 'user', {track: keywords}, (stream) ->

    stream.on 'data', (data) ->
      for socket in connectedSockets
        socket.emit 'tweet', data

    stream.on 'end', (reponse) ->
      console.log "ended #{response}"
      setTimeout handleStream(), 1000

    stream.on 'destroy', (response) ->
      console.log "destroyed #{reponse}"
      setTimeout handleStream(), 1000

# cors proxy and body parser
server.use restify.bodyParser()
server.use restify.fullResponse() # set CORS, eTag, other common headers

# attract screen
server.get /\/*$/, restify.serveStatic directory: './public', default: 'index.html'

server.listen (process.env.PORT or 8080), ->
  handleStream()
  console.info "[%s] #{server.name} listening at #{server.url}", process.pid