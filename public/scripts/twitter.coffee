socket = io.connect 'http://localhost:5200'

socket.on 'connect', -> $('.debug').addClass('connected')
socket.on 'disconnect', -> $('.debug').removeClass('connected')
socket.on 'tweet', (tweet) ->
    t = JSON.parse tweet
    $('#tweets').prepend("<li>[#{t.created_at}]@#{t.user.screen_name}: #{t.text}</li>")
    if t.entities?.media.length > 0
        for media in t.entities.media
            $('#tweets').prepend("<img src='#{media.media_url}' />")