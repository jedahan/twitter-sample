socket = io.connect 'http://localhost:5200'

socket.on 'connect', -> $('body').addClass('connected')
socket.on 'disconnect', -> $('body').removeClass('connected')
socket.on 'tweet', (tweet) ->
    console.log tweet
    t = JSON.parse tweet
    console.log t
    $('#tweets').prepend("<li>#{t.text}</li>")