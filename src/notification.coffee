stomp = require 'stompjs'
url = require 'url'

# A simple notification implementation. Change it to class that 
# accepts multiple notification hosts, implement retry mechanism
# and thus connect to healthy notification host and also distribute load

stompConnect = (mqUrl, callback) ->
    purl = url.parse mqUrl
    return callback new Error "Failed to parse URL #{mqUrl}" unless purl


    connectcb = (frame) =>
        callback client, purl.pathname

    errorcb = (error) =>
        console.log "stomp client failed due to error ", error
        console.log "Reconnecting in 10 sec"
        setTimeout connect, 10000


    connect = () =>
        client = stomp.overTCP purl.host, purl.port
        client.connect creds[0], creds[1], connectcb, errorcb

    creds = purl.auth.split(':')
    connect()


module.exports = stompConnect
