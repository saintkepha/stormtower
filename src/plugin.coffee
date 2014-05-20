##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

@include = ->
    tower = @settings.agent

    @head '/agents': ->
        @res.header('Content-MD5', tower.checksum())
        @res.send ''

    @get '/agents': ->
        @send tower.agents.list()

    # proxy operation for stormflash requests
    @all '/agents/:id/*': ->
        match = tower.agents.get @params.id
        if match? and match.bolt? and match.bolt.relay?
            @req.target = 8000
            @req.url = @params[0]
            match.bolt.relay @req, @res
        else
            @send 404
