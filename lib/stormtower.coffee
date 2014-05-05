
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

http = require('http')
util = require('util')

class stormtower
    
    activatedEndpoints = []
    
    # Constructor for stormtower class
    constructor: (interval = 2000) ->
        util.log 'stormtower constructor called'
        @cnameIntervaleMsec = interval
        
    startDiscovery: ->
        util.log 'stormtower cname discovery initiated'
        setInterval @cnameDiscovery, @cnameIntervaleMsec
        
    cnameDiscovery: =>
        http.get { hostname: 'localhost', port: 9000, path: '/cname' }, (res) ->
            res.on "data", (data) ->
                util.log 'cname discovery data: ' + data
                cnameList = JSON.parse data
                activatedEndpoints = (endpoints.cname for endpoints in cnameList)
            res.on "error", (e) ->
                util.log 'cname discovery error: ' + e.message
        
    getCnameList: ->
        activatedEndpoints
        

module.exports = stormtower


