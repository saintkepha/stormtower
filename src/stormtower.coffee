
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

StormAgent = require 'stormagent'

StormData = StormAgent.StormData

class TowerMinion extends StormData

    async = require 'async'
    http = require 'http'
    crypto = require 'crypto'
    streamBuffers = require 'stream-buffers'

    constructor: (@id, @bolt) ->
        @status = false
        @checksum = null
        @monitoring = false

        super id

    monitor: (interval) ->
        return if @monitoring # we don't want to schedule this multiple times...

        extend = require('util')._extend

        @monitoring = true
        async.whilst(
            () =>
                @monitoring
            (repeat) =>
                try
                    req = new streamBuffers.ReadableStreamBuffer
                    req.method = 'GET'
                    req.url    = '/status'
                    req.target = 5000

                    @log "monitor - checking #{@bolt.id} for status"
                    relay = @bolt.relay req
                    # destroy the request stream since it's been sent
                    req.destroy()
                    relay.on 'reply', (reply) =>
                        try
                            status = JSON.parse reply.body
                            copy = extend({},status)
                            delete copy.os # os info changes all the time...
                            md5 = crypto.createHash "md5"
                            md5.update JSON.stringify copy
                            checksum = md5.digest "hex"
                            unless checksum is @checksum
                                @checksum = checksum
                                unless @status
                                    @emit 'ready'
                                @status = status
                                @emit 'changed'
                        catch err
                            @log "unable to parse reply:", reply
                            @log "error:", err
                            relay.end()
                catch err
                    @log "monitor - minion discovery request failed:", err
                    try
                        req.destroy() if req?
                    catch err
                        @log "monitor - destroying request failed... (this should not happen)", err
                finally
                    @log "monitor - scheduling repeat at #{interval}"
                    setTimeout repeat, interval
            (err) =>
                @log "monitor - minion discovery stopped for: #{@id}"
                @monitoring = false
        )

    destroy: ->
        @monitoring = false

#-----------------------------------------------------------------

StormRegistry = StormAgent.StormRegistry

class TowerRegistry extends StormRegistry

    constructor: (filename) ->
        @on 'removed', (minion) ->
            minion.destroy() if minion.destroy?

        super filename

    get: (key) ->
        entry = super key
        return unless entry? and entry.status?
        entry.status.id ?= entry.id
        entry.status

#-----------------------------------------------------------------

StormBolt = require 'stormbolt'

class StormTower extends StormBolt

    # Constructor for stormtower class
    constructor: (config) ->
        super config
        # key routine to import itself
        @import module

        @minions = new TowerRegistry

        @clients.on 'added', (bolt) =>
            minion = new TowerMinion bolt.id, bolt
            minion.monitor @config.monitorInterval

            # during monitoring, ready will be emitted once status is retrieved
            minion.once 'ready', =>
                @app.io.sockets.emit 'minion.new', bolt.id, minion
                @minions.add bolt.id, minion
                minion.on 'changed', =>
                    @minions.emit 'changed'
                    @app.io.sockets.emit 'minion.update', bolt.id, minion

        @clients.on 'removed', (bolt) =>
            @log "boltstream #{bolt.id} is removed"
            entry = @minions.get bolt.id
            @app.io.sockets.emit 'minion.remove', bolt.id, entry if entry?
            @minions.remove bolt.id

    # super class overrides
    status: ->
        state = super
        state.minions = @minions.list()
        state

#module.exports = stormtower
module.exports = StormTower

#-------------------------------------------------------------------------------------------

if require.main is module
    console.log 'stormtower rising up to stand against the coming storm...'
    ###
    argv = require('minimist')(process.argv.slice(2))
    if argv.h?
        console.log """
            -h view this help
            -p port number
            -l logfile
            -d datadir
        """
        return

    config = {}
    config.port    = argv.p ? 5000
    config.logfile = argv.l ? "/var/log/stormtower.log"
    config.datadir = argv.d ? "/var/stormstack"
    ###

    config = null
    storm = null # override during dev
    agent = new StormTower config
    agent.run storm
    process.on 'uncaughtException' , (err) ->
        agent.log 'ALERT.. caught exception', err, err.stack
