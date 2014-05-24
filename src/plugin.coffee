##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

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
