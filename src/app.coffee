argv = require('optimist')
    .usage('Start stormtower with a configuration file.\nUsage: $0 -c <config file>')
    .demand('c')
    .default('c','/etc/stormstack/stormtower.json')
    .alias('c', 'file')
    .describe('c', 'location of stormtower configuration file')
    .argv

console.log 'stormtower rising up to stand against the coming storm...'

StormTower = require './stormtower'
agent = new StormTower
agent.run()
