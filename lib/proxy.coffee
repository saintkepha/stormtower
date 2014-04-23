##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

@include = ->

    @get '/stormtower/stormflash/*': ->
        console.log 'GET on /' + @request.params[0]
        @send 'GET success\n'
    
    @post '/stormtower/stormflash/*': ->
        console.log 'POST on /' + @request.params[0]
        @send 'POST success\n'
    
    @put '/stormtower/stormflash/*': ->
        console.log 'PUT on /' + @request.params[0]
        @send 'PUT success\n'
    
    @del '/stormtower/stormflash/*': ->
        console.log 'DELETE on /' + @request.params[0]
        @send 'DELETE success\n'
        

