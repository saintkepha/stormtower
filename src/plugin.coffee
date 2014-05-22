##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

@include = ->
    tower = @settings.agent

    @head '/agents': ->
        tower.log "calculating checksum..."
        checksum = tower.agents.checksum()
        tower.log "checksum: #{checksum}"
        @res.set 'Content-MD5', checksum
        @send 200

    @get '/agents': ->
        @send tower.agents.list()

    @get '/agents/:id': ->
        match = tower.agents.get @params.id
        if match?
            @send match
        else
            @send 404
