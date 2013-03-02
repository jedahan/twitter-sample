socket = io.connect 'http://localhost:5200'

socket.on 'connect', -> $('body').addClass('connected')
socket.on 'disconnect', -> $('body').removeClass('connected')
socket.on 'tweet', (tweet) -> $('#tweets').prepend("<li>#{tweet.text}</li>")