
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

http = require('http')
async = require('async')
crypto = require("crypto")

StormBolt = require 'stormbolt'

class StormTower extends StormBolt
    activatedEndpoints = []
    allEndPoints =
        globalChecksum: ""
        StormResponses: {}

    successStatusCodes = [200, 202, 204, 304]
    
    # Constructor for stormtower class
    constructor: (config) ->
        super config
        # key routine to import itself
        @import module

        @log '[constructor] stormtower object instantiating'
        @boltServerHost = @config.stormbolt.split(":")[0]
        @boltServerPort = @config.stormbolt.split(":")[1]
        @log '[constructor] stormbolt url: ', @boltServerHost
        @log '[constructor] stormbolt port: ', @boltServerPort
        
        @boltClientPort = 5000
        @pollingURL = '/'
        @pollingDelayMsec = 2000
        @pollingIntvMsec = 5000
        
        @cnameDisOptions =
            hostname: @boltServerHost
            port: @boltServerPort
            path: '/cname'
            method: 'GET'
            agent: false
            
        @cnamePollOptions =
            hostname: @boltServerHost
            port: @boltServerPort
            path: '/'
            method: 'GET'
            agent: false
        
    startPolling: ->
        @log '[startPolling] stormflash discovery is initiated'
        setInterval @cnameDiscovery, @pollingIntvMsec
        
    cnameDiscovery: =>
        setTimeout @stormflashPolling, @pollingDelayMsec
        req = http.request(@cnameDisOptions, (res) ->
            result = ''
            res.on "data", (chunk) ->
                result += chunk
            res.on "end", ->
                cnameList = JSON.parse result
                activatedEndpoints = (endpoints.cname for endpoints in cnameList)
                @log '[cnameDiscovery] active stormflash list: ', activatedEndpoints
        )
        req.on "error", (err) =>
            @log '[ERROR] [cnameDiscovery] error ', err
        req.end()
        
    stormflashPolling: =>
        for key, value of allEndPoints.StormResponses
            if key not in activatedEndpoints
                @log "[stormflashPolling] #{key} stormflash removed from master table"
                delete allEndPoints.StormResponses[key]
            
        httpOptions = @cnamePollOptions
        boltClientPort = @boltClientPort
        async.each activatedEndpoints, ((cname, callback) =>
            @log "[stormflashPolling] #{cname}] polling started"
            boltHeaders =
                'stormbolt-target' : "#{cname}: #{boltClientPort}"
            
            httpOptions.headers = boltHeaders
            req = http.request(httpOptions, (res) =>
                result = ''
                res.on "data", (chunk) ->
                    result += chunk
                res.on "end", =>
                    @log "[stormflashPolling] #{cname} response status ", res.statusCode
                    
                    if res.statusCode is 200
                        cnameDetails = JSON.parse result
                        md5 = crypto.createHash("md5")
                        md5.update result
                        md5CheckSum = md5.digest("hex")
                        now = new Date
                        timeStamp = now.getUTCMonth() +  ':' + now.getUTCDate() + ':' + now.getUTCFullYear() + ' ' + now.getUTCHours() + ':' + now.getUTCMinutes() + ':' + now.getUTCSeconds() + ' UTC'
                        allEndPoints.StormResponses[cname] =
                            Response: cnameDetails
                            checksum: md5CheckSum
                            lastUpdated: timeStamp
                    else
                        @log "[stormflashPolling] #{cname} stormflash removed from master table"
                        delete allEndPoints.StormResponses[cname]
                        
                    callback()
                    return
            )
            req.on "error", (err) =>
                @log "[stormflashPolling] #{cname} error ", err
                @log "[stormflashPolling] #{cname} stormflash removed from master table"
                delete allEndPoints.StormResponses[cname]
                callback (err + cname)
                @next
            req.end()
        ), (err) =>
        
            unless err?
                @log '[stormflashPolling] polling successful'
            else
                @log '[stormflashPolling] polling error ', err

            globalMD5 = crypto.createHash("md5")
            for key, value of allEndPoints.StormResponses
                @log '[stormflashPolling] adding md5 checksum of ', key
                globalMD5.update JSON.stringify(allEndPoints.StormResponses[key].Response)
                
            allEndPoints.globalChecksum = globalMD5.digest("hex")
            @log '[stormflashPolling] global md5 checksum ', allEndPoints.globalChecksum
            
            @log '---------------- MASTER TABLE ----------------'
            console.log allEndPoints
            @log '------------------------------------------'
        
            return
        
    getPollingData: (cnameList) ->
        @log '[getPollingData] cname list received: ' + cnameList
        unless cnameList?
            cnameList = (key for key, value of allEndPoints.StormResponses)
            @log '[getPollingData] cname list set to: ' + cnameList
            
        allEndPoints.globalChecksum = @getGlobalChecksum(cnameList)
        resObj =
            globalChecksum: allEndPoints.globalChecksum
            agents: []
            
        unless cnameList?
            return allEndPoints.StormResponses
        else
            for cname in cnameList
                resObj.agents.push ({"cname": cname, "response": allEndPoints.StormResponses[cname].Response, "checksum": allEndPoints.StormResponses[cname].checksum, "lastUpdated": allEndPoints.StormResponses[cname].lastUpdated})
            return resObj
        
    getGlobalChecksum: (cnameList) ->
        globalMD5 = crypto.createHash("md5")
        @log '[getGlobalChecksum] received cname list ', cnameList
        
        unless cnameList?
            @log '[getGlobalChecksum] returning the current global md5 checksum'
            return allEndPoints.globalChecksum
        else
            for cname in cnameList
                @log '[getGlobalChecksum] adding md5 checksum of ', cname
                globalMD5.update JSON.stringify(allEndPoints.StormResponses[cname].Response)
                
            return globalMD5.digest("hex")

    httpReqSender = (httpOptions, reqBody, timeout, cname, callback) ->
        @log "[httpReqSender] #{cname}"
        returnObj =
            status: 500
            output: {}
        
        inputData = JSON.stringify reqBody
        req = http.request(httpOptions, (res) =>
            result = ''
        
            res.on "data", (chunk) ->
                result += chunk
            res.on "end", =>
                @log "[httpReqSender] #{cname} response status ", res.statusCode
                returnObj.status = res.statusCode
            
                if res.statusCode in successStatusCodes
                    @log "[httpReqSender] #{cname} response: ", result
                    returnObj.output = JSON.parse(result)
                else
                    if result
                        @log "[httpReqSender] #{cname} failure: ", result.split('\n')[0]
                        returnObj.output =
                            error: result.split('\n')[0]
                    else
                        returnObj.output =
                            error: 'info not available'
                
                callback (returnObj)
        )
        req.on "error", (err) =>
            @log "[httpReqSender] #{cname} error ", err
            returnObj.output =
                error: err
            callback returnObj
       
        req.setTimeout timeout, (reply) =>
            @log "[httpReqSender] #{cname} timeout: "
            returnObj.status = 408
            returnObj.output =
                error: 'http request got timeout'
            callback (returnObj)
        
        if httpOptions.method in ['POST', 'PUT'] and inputData
            @log "[httpReqSender] #{cname} input data: ", inputData
            req.write inputData
        
        req.end()
        @log "[httpReqSender] #{cname} request forwarded"

    
#module.exports = stormtower
module.exports = (args) ->
    new StormTower args
