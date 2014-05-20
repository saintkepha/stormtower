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
        if match? and match.bolt?
            req = request
                method: @req.method
                uri: @params[1]
                timeout: 5000
                body: @body
            req.target = 8000
            match.bolt.relay req, (chunk,complete) =>
                @next chunk if chunk instanceof Error
                if complete
                    @send = chunk
        else
            @send 404
