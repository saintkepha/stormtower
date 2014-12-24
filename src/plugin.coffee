##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

crypto = require 'crypto' # for checksum capability
extend = require('util')._extend

@include = ->
    tower = @settings.agent

    @head '/minions': ->
        checksum = tower.minions.checksum()
        tower.log "checksum: #{checksum}"
        @res.set 'Content-MD5', checksum
        @send ''

    @get '/minions': ->
        @send tower.minions.list()

    @get '/minions/:id': ->
        match = tower.minions.get @params.id
        if match?
            @send match
        else
            @send 404

    @head '/minions/:id': ->
        match = tower.minions.get @params.id
        if match?
            copy = extend({}, match)
            delete copy.os
            md5 = crypto.createHash "md5"
            md5.update JSON.stringify copy
            @res.set 'Content-MD5', md5.digest "hex"
            @send ''
        else
            @res.status(404)
            @send ''
