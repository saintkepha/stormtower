##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

@include = ->
    tower = @settings.agent

    @head '/agents': ->
        @res.header 'Content-MD5', tower.agents.checksum()
        @res.send ''

    @get '/agents': ->
        @send tower.agents.list()

    @get '/agents/:id': ->
        match = tower.agents.get @params.id
        if match?
            @send match
        else
            @send 404
