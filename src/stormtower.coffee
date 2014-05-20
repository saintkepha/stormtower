
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

StormAgent = require 'stormagent'

StormData = StormAgent.StormData

class TowerAgent extends StormData

    async = require('async')
    request = require 'request'

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
                    req = request
                        url: "http://#{@bolt.id}/"
                        timeout: interval
                        encoding: 'utf8'
                    req.target = 8000
                    @bolt.relay req, (reply,complete) ->
                        return unless reply?
                        return if reply? and not reply instanceof Error and not complete

                        unless reply instanceof Error
                            md5 = crypto.createHash "md5"
                            md5.update reply
                            checksum = md5.digest "hex"
                            unless checksum is @checksum
                                status = JSON.parse reply
                                @status = status
                                @emit 'changed', status, checksum
                                callback status if callback?
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

