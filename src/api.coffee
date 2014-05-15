##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

util = require('util')
requestify = require('requestify')

@include = ->
    stormtower = require('./stormtower')(@configObj)
    stormtower.startPolling()
    boltReqTimeout = 10000
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
            @res.statusCode = response.getCode()
            @res.json JSON.parse(response.body)
            return

        util.log "[PROXY GET] #{cname} request forwarded"
        
    @post '/stormtower/stormflash/*': ->
        util.log '[PROXY POST] url: /' + @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        reqURL = "http://#{boltHostname}:#{boltPort}/#{@request.params[0]}"
        util.log "[PROXY POST] target stormflash: #{cname}"
        util.log "[PROXY POST] #{cname} input: "
        console.log @body
        
        reqOptions =
            body: @body
            method: 'POST'
            dataType: 'json'
            timeout: boltReqTimeout
            headers:
                'stormbolt-target': @request.headers['stormbolt-target']
        
        reqBolt = requestify.request(reqURL, reqOptions)
        reqBolt.then (response) =>
            util.log "[PROXY POST] #{cname} response status: " + response.getCode()
            util.log "[PROXY POST] #{cname} response output: "
            console.log response.getBody()
            @res.statusCode = response.getCode()
            @res.json JSON.parse(response.body)
        reqBolt.fail (err) =>
            util.log "[PROXY POST] #{cname} operation failed: "
            util.log "[PROXY POST] #{cname} status: " + err.code
            errorMsg = err.body.split('\n')[0]
            errResponse =
                message: errorMsg
            util.log "[PROXY POST] #{cname} reason: " + errorMsg
            @res.statusCode = err.code
            @res.json errResponse
        reqBolt.timeout boltReqTimeout, =>
            timeout = true
            util.log "[PROXY POST] #{cname} operation timeout: "
            @res.statusCode = 408
            @res.json JSON.parse("{'message': 'http request got timeout}")
            
        return
        util.log "[PROXY POST] #{cname} request forwarded"
        
    @put '/stormtower/stormflash/*': ->
        util.log '[PROXY] PUT on /' + @request.params[0]
        @send 'PUT success\n'
        
    @del '/stormtower/stormflash/*': ->
        util.log '[PROXY] DELETE on /' + @request.params[0]
        @send 'DELETE success\n'




