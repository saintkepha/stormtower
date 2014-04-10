
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

class stormtower
    
    # Constructor for stormtower class
    constructor: (configJsonObj) ->
        # Defining default values of optional configurations
        @config = 
            uid : "stormtower"
            port : "8080"
        
        console.log "reading stormtower configuration..."
        
        # Validate configuration details for stormtower own identity in network
        if configJsonObj["stormtower-uid"]
            @config.uid = configJsonObj["stormtower-uid"]
            console.log 'stormtower uid is: ' + @config.uid
        else
            console.log 'stormtower uid set as default: ' + @config.uid
        
        # Validate configuration details for jappajs server
        if configJsonObj["stormtower-port"]
            @config.port = configJsonObj["stormtower-port"]
            console.log 'stormtower port is: ' + @config.port
        else
            console.log 'stormtower port set as default: ' + @config.port
        
        # Validate configuration details for stormbolt server
        if configJsonObj["stormbolt"]
            @config.stormbolt = configJsonObj["stormbolt"]
            console.log 'stormbolt url is: ' + @config.stormbolt
        else
            console.log 'stormbolt url details missing in config file'
        
    # Returns the configuration details based on which stormtower service is running
    details: ->
        console.log 'stormtower running with below configuration: '
        for key , value of @config
            console.log key + ' = ' + value
        return @config
    
    # initializes stormtower service with given configuration
    start: (callback) ->
        console.log 'initializing stormtower...'
        
        if @config.stormbolt
            @startServer()
            callback new Error "jappajs service stopped unexpectedly..."
        else
            callback new Error "stormtower service requires stormbolt url details"
        
    # Method to start stormtower service with jappajs server
    startServer: ->
        console.log 'jappajs server to start here...'
    

module.exports = stormtower

