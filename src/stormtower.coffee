
# The stormtower class which starts jappajs service and
# acts as a proxy between stormgate/stormlight to communicate with VSC stormflash

StormAgent = require 'stormagent'

StormData = StormAgent.StormData

class TowerMinion extends StormData

    async = require 'async'
    http = require 'http'
    crypto = require 'crypto'

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
                    streamBuffers = require 'stream-buffers'
                    req = new streamBuffers.ReadableStreamBuffer
                    req.method = 'GET'
                    req.url    = '/'
                    req.target = 5000

                    @log "monitor - checking #{@bolt.id} for status"
                    relay = @bolt.relay req
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
                @minions.add bolt.id, minion
                minion.on 'changed', =>
                    @minions.emit 'changed'

        @clients.on 'removed', (bolt) =>
            @log "boltstream #{bolt.id} is removed"
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

    # Garbage collect every 2 sec
    # Run node with --expose-gc
    setInterval (
        () -> gc()
    ), 2000 if gc?
