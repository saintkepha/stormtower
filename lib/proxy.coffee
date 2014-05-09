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
        cnameList = @req.query.cnames
        util.log '[PROXY] cname list received is ' + cnameList
        @res.header('Content-MD5', stormtower.getGlobalChecksum(cnameList))
        @res.send ''

    @get '/': ->
        util.log '[PROXY] GET /'
        cnameList = @req.query.cnames
        util.log '[PROXY] cname list received is ' + cnameList
        @json stormtower.getPollingData(cnameList)

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




