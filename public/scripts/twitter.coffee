socket = io.connect 'http://localhost:5200'

@store = {tweets: []}
@rendertweets = ->
    dust.render "tweet", window.store, (err, out) ->
        $('#tweets').html(out)

socket.on 'connect', -> console.log 'connected'
socket.on 'disconnect', -> console.log 'disconnected'
socket.on 'tweet', (tweet) ->
    t = {
        time: tweet.created_at
        user: tweet.user.screen_name
        text: tweet.text
        media: tweet.entities.media?[0]?.media_url
    }

    window.store.tweets.push t
    window.rendertweets()

$(document).ready ->
    source   = $("template").html()
    compiled = dust.compile(source, "tweet")
    dust.loadSource compiled

    window.rendertweets()