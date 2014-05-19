##
## The zappajs server running as a proxy
## Receives the http CRUD requests and forwards to desired target
##


@include = ->
    agent = @settings.agent
    log = agent.log
    agent.startPolling()
    
    httpOptions =
        agent: false
        port: agent.config.stormbolt.split(':')[1]
        hostname: agent.config.stormbolt.split(':')[0]
        
    reqTimeout =
        get: 5000
        put: 5000
        del: 5000
        post: 15000
    
    
    @head '/stormtower': ->
        log '[PROXY] HEAD /'
        cnameList = @req.query.cnames
        log '[PROXY] cname list received is ', cnameList
        @res.header('Content-MD5', agent.getGlobalChecksum(cnameList))
        @res.send ''
        
        
    @get '/stormtower': ->
        log '[PROXY] GET /'
        cnameList = @req.query.cnames
        log '[PROXY] cname list received is ', cnameList
        @json agent.getPollingData(cnameList)
        
        
    @get '/stormtower/stormflash/*': ->
        log '[PROXY GET] url: /', @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        
        httpOptions.method = 'GET'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
             
        resZappajs = @res
        agent.httpReqSender httpOptions, null, reqTimeout.get, cname, (reply) =>
            log "[PROXY GET] #{cname} received callback ", reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output

        log "[PROXY GET] #{cname} response sent back"

        
    @post '/stormtower/stormflash/*': ->
        log '[PROXY POST] url: /', @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        
        httpOptions.method = 'POST'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
            
        resZappajs = @res
        agent.httpReqSender httpOptions, @body, reqTimeout.post, cname, (reply) =>
            log "[PROXY POST] #{cname} received callback ", reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output
        
        log "[PROXY POST] #{cname} response sent back"
        
        
    @put '/stormtower/stormflash/*': ->
        log '[PROXY PUT] url: /', @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        
        httpOptions.method = 'PUT'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
             
        resZappajs = @res
        agent.httpReqSender httpOptions, @body, reqTimeout.put, cname, (reply) =>
            log "[PROXY PUT] #{cname} received callback " + reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output
        
        log "[PROXY PUT] #{cname} response sent back"
        
        
    @del '/stormtower/stormflash/*': ->
        log '[PROXY DELETE] url: /', @request.params[0]
        cname = @request.headers['stormbolt-target'].split(':')[0]
        
        httpOptions.method = 'DELETE'
        httpOptions.path = '/'+ @request.params[0]
        httpOptions.headers =
            'stormbolt-target': @request.headers['stormbolt-target']
             
        resZappajs = @res
        agent.httpReqSender httpOptions, null, reqTimeout.del, cname, (reply) =>
            log "[PROXY DELETE] #{cname} received callback ", reply
            resZappajs.statusCode = reply.status
            resZappajs.json reply.output

        log "[PROXY DELETE] #{cname} response sent back"


