##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##
util = require('util')

@include = ->
    storm = require('./stormtower')
    stormtower = new storm(1000)
    stormtower.startDiscovery()
    
    @get '/stormtower/activated': ->
        @send JSON.stringify(stormtower.getCnameList())
    
    @get '/stormtower/stormflash/*': ->
        util.log 'GET on /' + @request.params[0]
        @send 'GET success\n'
    
    @post '/stormtower/stormflash/*': ->
        util.log 'POST on /' + @request.params[0]
        @send 'POST success\n'
    
    @put '/stormtower/stormflash/*': ->
        util.log 'PUT on /' + @request.params[0]
        @send 'PUT success\n'
    
    @del '/stormtower/stormflash/*': ->
        util.log 'DELETE on /' + @request.params[0]
        @send 'DELETE success\n'
        


