argv = require('optimist')
    .usage('Start stormtower with a configuration file.\nUsage: $0 -c <config file>')
    .demand('c')
    .default('c','/etc/stormstack/stormtower.json')
    .alias('c', 'file')
    .describe('c', 'location of stormtower configuration file')
    .argv

config = require('../package').config

util = require('util')

util.log "stormtower coming up as the NFV application controller..."

StormTower = require './stormtower'
agent = new StormTower config

# agent.on "running", ->
#     @log "starting activation..."
#     @activate null, (err, status) =>
#         @log "activation completed with:", status

agent.run()
