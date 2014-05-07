
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

http = require('http')
util = require('util')

class stormtower
    activatedEndpoints = []
    allEndPoints =
        globalChecksum: ""
        StormResponses: {}
    
    # Constructor for stormtower class
    constructor: (cnameInterval = 2000, pollingInterval = 10000) ->
        util.log 'stormtower constructor called'
        @boltClientPort = 5000
        @boltServerPort = 9000
        @pollingURL = '/modules'
        @boltServerHost = 'localhost'
        @cnameDisIntvMsec = cnameInterval
        @pollingIntvMsec = pollingInterval
        
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
        
    startDiscovery: ->
        util.log 'cname discovery initiated'
        setInterval @cnameDiscovery, @cnameDisIntvMsec
        
    cnameDiscovery: =>
        req = http.request(@cnameDisOptions, (res) ->
            result = ''
            res.on "data", (chunk) ->
                result += chunk
            res.on "end", ->
                util.log 'cname discovery data: ' + result
                cnameList = JSON.parse result
                activatedEndpoints = (endpoints.cname for endpoints in cnameList)
        )
        req.on "error", (err) ->
            util.log err
        req.end()
        
    startPolling: ->
        util.log 'endpoint polling initiated'
        setInterval @cnamePolling, @pollingIntvMsec
        
    cnamePolling: =>
        for cname in activatedEndpoints
            boltHeaders =
                'stormbolt-target' : "#{cname}: #{@boltClientPort}"
            console.log "target for polling is " + boltHeaders['stormbolt-target']
            @cnamePollOptions.headers = boltHeaders
            req = http.request(@cnamePollOptions, (res) ->
                result = ''
                res.on "data", (chunk) ->
                    result += chunk
                res.on "end", ->
                    util.log 'cname polling data: ' + result
                    cnameDetails = JSON.parse result
                    allEndPoints.StormResponses[cname] =
                        response: cnameDetails
                        checksum: "abcd"
            )
            req.on "error", (err) ->
                util.log err
            req.end()
        
    getCnameList: ->
        activatedEndpoints
        
    getPollingData: ->
        allEndPoints
    
module.exports = stormtower



