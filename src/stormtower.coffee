
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

StormAgent = require 'stormagent'

StormData = StormAgent.StormData

class TowerAgent extends StormData

    async = require 'async'
    http = require 'http'
    crypto = require 'crypto'

    constructor: (@id, @bolt) ->
        @status = false
        super id

    monitor: (interval, callback) ->
        @monitoring = true
        async.whilst(
            () =>
                @monitoring
            (repeat) =>
                try
                    ### EXPERIMENTAL
                    streamBuffers = require 'stream-buffers'
                    req = new streamBuffers.ReadableStreamBuffer
                    req.method  = 'GET'
                    req.url     = '/'
                    req.headers = null
                    req.put "GET / HTTP/1.1\n\n", "utf8"
                    ###
                    @log "monitor - checking #{@bolt.id}"
                    req = http.request '/'
                    req.target = 8000
                    @bolt.relay req, (reply,body) =>
                        unless reply instanceof Error
                            md5 = crypto.createHash "md5"
                            md5.update body
                            checksum = md5.digest "hex"
                            unless checksum is @checksum
                                try
                                    status = JSON.parse body
                                    @status = status
                                    @emit 'changed', status, checksum
                                    callback status if callback?
                                catch err
                                    @log "unable to parse reply:", body
                                    @log "error:", err
                        else
                            @log "error:",reply

                        setTimeout repeat, interval

                catch err
                    @log "agent discovery request failed:", err
                    setTimeout repeat, interval
            (err) =>
                @log "agent discovery stopped for: #{@id}"
        )

    destroy: ->
        @monitoring = false

#-----------------------------------------------------------------

StormRegistry = StormAgent.StormRegistry

class TowerRegistry extends StormRegistry

    constructor: (filename) ->
        @on 'removed', (tagent) ->
            tagent.destroy() if tagent.destroy?

        super filename

    get: (key) ->
        entry = super key
        return unless entry?
        entry.status

#-----------------------------------------------------------------

StormBolt = require 'stormbolt'

class StormTower extends StormBolt

    crypto = require("crypto")

    # Constructor for stormtower class
    constructor: (config) ->
        super config
        # key routine to import itself
        @import module

        @agents = new TowerRegistry

        @checksum = ->
            md5 = crypto.createHash "md5"
            md5.update agent for agent in @agents.list()
            md5.digest "hex"

        @clients.on 'added', (bolt) =>
            entry = @agents.add bolt.id, new TowerAgent bolt.id, bolt
            entry.on 'changed', (status, checksum) ->
                @agents.emit 'changed'
            entry.monitor @config.repeatdelay, (status) =>
                # this callback triggers when something changes

                ###
                entry.status = data
                @agents.update bolt.id, entry
                ###
        @clients.on 'removed', (bolt) =>
            @agents.remove bolt.id

    # super class overrides
    status: ->
        state = super
        state.agents = @agents.list()
        state

#module.exports = stormtower
module.exports = StormTower

