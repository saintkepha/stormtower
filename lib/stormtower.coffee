
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

http = require('http')
util = require('util')
crypto = require("crypto")


class stormtower
    activatedEndpoints = []
    allEndPoints =
        globalChecksum: ""
        StormResponses: {}
    
    # Constructor for stormtower class
    constructor: (pollingInterval = 5000) ->
        util.log '[constructor] stormtower object instantiated'
        @boltClientPort = 5000
        @boltServerPort = 9000
        @pollingURL = '/'
        @boltServerHost = 'localhost'
        @pollingIntvMsec = pollingInterval
        @pollingDelayMsec = 2000
        
        @cnameDisOptions =
            hostname: @boltServerHost
            port: @boltServerPort
            path: '/cname'
            method: 'GET'
            agent: false
            
        @cnamePollOptions =
            hostname: @boltServerHost
            port: @boltServerPort
            path: '/cname'
            method: 'GET'
            agent: false
        
    startPolling: ->
        util.log '[startDiscovery] stormflash discovery is initiated'
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
        util.log '---------------- MASTER TABLE ----------------'
        console.log allEndPoints
        util.log '------------------------------------------'
        for key, value of allEndPoints.StormResponses
            if key not in activatedEndpoints
                util.log '[stormflashPolling] stormflash ' + key + ' removed from master table'
                delete allEndPoints.StormResponses[key]
            
        for cname in activatedEndpoints
            boltHeaders =
                'stormbolt-target' : "#{cname}: #{@boltClientPort}"
            util.log '[stormflashPolling] stormflash target is ' + boltHeaders['stormbolt-target']
            @cnamePollOptions.headers = boltHeaders
            req = http.request(@cnamePollOptions, (res) ->
                result = ''
                res.on "data", (chunk) ->
                    result += chunk
                res.on "end", ->
                    cnameOrig = res.req._headers['stormbolt-target'].split(':')[0]
                    util.log '[stormflashPolling] [' + cnameOrig + '] response status '+ res.statusCode
                    if res.statusCode is 200
                        cnameDetails = JSON.parse result
                        md5 = crypto.createHash("md5")
                        md5.update result
                        md5CheckSum = md5.digest("hex")
                        allEndPoints.StormResponses[cnameOrig] =
                            Response: cnameDetails
                            checksum: md5CheckSum
                        
                    util.log '[stormflashPolling] [' + cnameOrig + '] reponse ends'
            )
            req.on "error", (err) ->
                cnameOrig = res.req._headers['stormbolt-target'].split(':')[0]
                util.log '[ERROR] [stormflashPolling] [' + cnameOrig + '] error ' + err
            req.end()
        
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
                resObj.agents.push ({"cname": cname, "response": allEndPoints.StormResponses[cname].Response, "checksum": allEndPoints.StormResponses[cname].checksum})
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
    
module.exports = stormtower



