
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

http = require('http')
util = require('util')
async = require('async')
crypto = require("crypto")


class stormtower
    activatedEndpoints = []
    allEndPoints =
        globalChecksum: ""
        StormResponses: {}
    
    # Constructor for stormtower class
    constructor: (configObj) ->
        util.log '[constructor] stormtower object instantiating'
        @boltServerHost = configObj.stormbolt.split(":")[0]
        @boltServerPort = configObj.stormbolt.split(":")[1]
        util.log '[constructor] stormbolt url: ' + @boltServerHost
        util.log '[constructor] stormbolt port: ' + @boltServerPort
        
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
        util.log '[startPolling] stormflash discovery is initiated'
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
                util.log '[cnameDiscovery] active stormflash list: ' + activatedEndpoints
        )
        req.on "error", (err) ->
            util.log err
            util.log '[ERROR] [cnameDiscovery] error ' + err
        req.end()
        
    stormflashPolling: =>
        for key, value of allEndPoints.StormResponses
            if key not in activatedEndpoints
                util.log '[stormflashPolling] ' + key + ' stormflash removed from master table'
                delete allEndPoints.StormResponses[key]
            
        httpOptions = @cnamePollOptions
        boltClientPort = @boltClientPort
        async.each activatedEndpoints, ((cname, callback) ->
            util.log "[stormflashPolling] #{cname}] polling started"
            boltHeaders =
                'stormbolt-target' : "#{cname}: #{boltClientPort}"
            
            httpOptions.headers = boltHeaders
            req = http.request(httpOptions, (res) ->
                result = ''
                res.on "data", (chunk) ->
                    result += chunk
                res.on "end", ->
                    util.log "[stormflashPolling] #{cname} response status " + res.statusCode
                    
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
                        util.log '[stormflashPolling] ' + cname + ' stormflash removed from master table'
                        delete allEndPoints.StormResponses[cname]
                        
                    callback()
                    return
            )
            req.on "error", (err) ->
                util.log "[stormflashPolling] #{cname} error " + err
                util.log '[stormflashPolling] #{cname} stormflash removed from master table'
                delete allEndPoints.StormResponses[cname]
                callback (err + cname)
                @next
            req.end()
        ), (err) ->
        
            unless err?
                util.log '[stormflashPolling] polling successful'
            else
                util.log '[stormflashPolling] polling error ' + err

            util.log '---------------- MASTER TABLE ----------------'
            console.log allEndPoints
            util.log '------------------------------------------'
        
            return
        
    getPollingData: (cnameList) ->
        util.log '[getPollingData] cname list received: ' + cnameList
        unless cnameList?
            cnameList = (key for key, value of allEndPoints.StormResponses)
            util.log '[getPollingData] cname list set to: ' + cnameList
            
        allEndPoints.globalChecksum = @getGlobalChecksum(cnameList)
        resObj =
            getGlobalChecksum: allEndPoints.globalChecksum
            agents: []
            
        unless cnameList?
            return allEndPoints.StormResponses
        else
            for cname in cnameList
                resObj.agents.push ({"cname": cname, "response": allEndPoints.StormResponses[cname].Response, "checksum": allEndPoints.StormResponses[cname].checksum, "lastUpdated": allEndPoints.StormResponses[cname].lastUpdated})
            return resObj
        
    getGlobalChecksum: (cnameList) ->
        globalMD5 = crypto.createHash("md5")
        util.log '[getGlobalChecksum] received cname list ' + cnameList
        unless cnameList?
            util.log '[getGlobalChecksum] adding cname to the list '
            cnameList = (key for key, value of allEndPoints.StormResponses)
            
        for cname in cnameList
            util.log '[getGlobalChecksum] adding md5 checksum of ' + cname
            globalMD5.update JSON.stringify(allEndPoints.StormResponses[cname].Response)
            
        allEndPoints.globalChecksum = globalMD5.digest("hex")
        util.log '[getGlobalChecksum] global md5 checksum ' + allEndPoints.globalChecksum
        allEndPoints.globalChecksum
    
#module.exports = stormtower
module.exports = (args) ->
    new stormtower args



