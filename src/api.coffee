##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##

http = require('http')
util = require('util')

successStatusCodes = [200, 202, 204, 304]

httpReqSender = (httpOptions, reqBody, timeout, cname, callback) ->
    util.log "[httpReqSender] #{cname}"
    returnObj =
        status: 500
        output: {}
        
    inputData = JSON.stringify reqBody
    req = http.request(httpOptions, (res) =>
        result = ''
        
        res.on "data", (chunk) ->
            result += chunk
        res.on "end", ->
            util.log "[httpReqSender] #{cname} response status " + res.statusCode
            returnObj.status = res.statusCode
            
            if res.statusCode in successStatusCodes
                util.log "[httpReqSender] #{cname} response: " + result
                returnObj.output = JSON.parse(result)
            else
                if result
                    util.log "[httpReqSender] #{cname} failure: " + result.split('\n')[0]
                    returnObj.output =
                        error: result.split('\n')[0]
                else
                    returnObj.output =
                        error: 'info not available'
                
            callback (returnObj)
    )
    req.on "error", (err) ->
        util.log "[httpReqSender] #{cname} error " + err
        returnObj.output =
            error: err
        callback returnObj
       
    req.setTimeout timeout, (reply) ->
        util.log "[httpReqSender] #{cname} timeout: "
        returnObj.status = 408
        returnObj.output =
            error: 'http request got timeout'
        callback (returnObj)
        
    if httpOptions.method in ['POST', 'PUT'] and inputData
        util.log "[httpReqSender] #{cname} input data: " + inputData
        req.write inputData
        
    req.end()
    util.log "[httpReqSender] #{cname} request forwarded"


@include = ->
    stormtower = require('./stormtower')(@configObj)
    stormtower.startPolling()
    
    httpOptions =
        agent: false
        port: @configObj.stormbolt.split(':')[1]
        hostname: @configObj.stormbolt.split(':')[0]
        
    reqTimeout =
        get: 5000
        put: 5000
        del: 5000
        post: 15000
    
    
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
        
        httpOptions.method = 'GET'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
             
        resZappajs = @res
        httpReqSender httpOptions, null, reqTimeout.get, cname, (reply) ->
            util.log "[PROXY GET] #{cname} received callback " + util.inspect reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output

        util.log "[PROXY GET] #{cname} response sent back"

        
    @post '/stormtower/stormflash/*': ->
        util.log '[PROXY POST] url: /' + @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        
        httpOptions.method = 'POST'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
            
        resZappajs = @res
        httpReqSender httpOptions, @body, reqTimeout.post, cname, (reply) ->
            util.log "[PROXY POST] #{cname} received callback " + util.inspect reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output
        
        util.log "[PROXY POST] #{cname} response sent back"
        
        
    @put '/stormtower/stormflash/*': ->
        util.log '[PROXY PUT] url: /' + @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        
        httpOptions.method = 'PUT'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
             
        resZappajs = @res
        httpReqSender httpOptions, @body, reqTimeout.put, cname, (reply) ->
            util.log "[PROXY PUT] #{cname} received callback " + util.inspect reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output
        
        util.log "[PROXY PUT] #{cname} response sent back"
        
        
    @del '/stormtower/stormflash/*': ->
        util.log '[PROXY DELETE] url: /' + @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        
        httpOptions.method = 'DELETE'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
             
        resZappajs = @res
        httpReqSender httpOptions, null, reqTimeout.del, cname, (reply) ->
            util.log "[PROXY DELETE] #{cname} received callback " + util.inspect reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output

        util.log "[PROXY DELETE] #{cname} response sent back"


