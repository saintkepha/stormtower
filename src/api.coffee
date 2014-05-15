##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

util = require('util')
requestify = require('requestify')

@include = ->
    stormtower = require('./stormtower')(@configObj)
    stormtower.startPolling()
    boltPort = @configObj.stormbolt.split(':')[1]
    boltHostname = @configObj.stormbolt.split(':')[0]
    
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
        
    @get '/stormtower/stormflash/*': ->
        util.log '[PROXY GET] url: /' + @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        reqURL = "http://#{boltHostname}:#{boltPort}/#{@request.params[0]}"
        util.log "[PROXY GET] target: #{cname}"
        requestify.get(reqURL, {
            method: 'GET'
            headers:
                'stormbolt-target': @request.headers['stormbolt-target']
        }).then (response) =>
            util.log "[PROXY GET] #{cname} response status: " + response.getCode()
            util.log "[PROXY GET] #{cname} response output: "
            console.log response.getBody()
            @res.status = response.getCode()
            @res.json JSON.parse(response.body)
            return

        util.log "[PROXY GET] #{cname} request forwarded"
        
    @post '/stormtower/stormflash/*': ->
        util.log '[PROXY] POST on /' + @request.params[0]
        @send 'POST success\n'
        
    @put '/stormtower/stormflash/*': ->
        util.log '[PROXY] PUT on /' + @request.params[0]
        @send 'PUT success\n'
        
    @del '/stormtower/stormflash/*': ->
        util.log '[PROXY] DELETE on /' + @request.params[0]
        @send 'DELETE success\n'




