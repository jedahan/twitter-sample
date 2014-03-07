socket = io.connect 'http://localhost:5200'

store = {tweets: []}

socket.on 'connect', -> console.log 'connected'
socket.on 'disconnect', -> console.log 'disconnected'
socket.on 'tweet', (tweet) ->
    t = {
        time: tweet.created_at
        user: tweet.user.screen_name
        text: tweet.text
        media: tweet.entities.media?[0]?.media_url
    }

    store.tweets << t

    $('#tweets').prepend("<li>@#{t.user}: #{t.text}<img src='#{t.media}' /></li>")