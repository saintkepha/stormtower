##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##
util = require('util')

@include = ->
    storm = require('./stormtower')
    stormtower = new storm(2000, 5000)
    stormtower.startDiscovery()
    stormtower.startPolling()

    @head '/': ->
        util.log '[PROXY] HEAD /'
        @res.header('Content-MD5', stormtower.getGlobalChecksum())
        @res.send ''

    @get '/': ->
        util.log '[PROXY] GET /'
        @json stormtower.getPollingData()

    @get '/stormtower/active': ->
        util.log '[PROXY] GET /stormtower/active/ '
        @json stormtower.getCnameList()

    @get '/stormtower/stormflash/*': ->
        util.log '[PROXY] GET on /' + @request.params[0]
        @send 'GET success\n'

    @post '/stormtower/stormflash/*': ->
        util.log '[PROXY] POST on /' + @request.params[0]
        @send 'POST success\n'

    @put '/stormtower/stormflash/*': ->
        util.log '[PROXY] PUT on /' + @request.params[0]
        @send 'PUT success\n'

    @del '/stormtower/stormflash/*': ->
        util.log '[PROXY] DELETE on /' + @request.params[0]
        @send 'DELETE success\n'




