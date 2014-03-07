socket = io.connect 'http://localhost:5200'

socket.on 'connect', -> console.log 'connected'
socket.on 'disconnect', -> console.log 'disconnected'
socket.on 'tweet', (tweet) ->
    $('#tweets').prepend("<li>[#{tweet.created_at}]@#{tweet.user.screen_name}: #{tweet.text}</li>")
    if tweet.entities?.media.length > 0
        for media in tweet.entities.media
            $('#tweets').prepend("<img src='#{media.media_url}' />")