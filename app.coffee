argv = require('optimist')
    .usage('Start stormtower with a configuration file.\nUsage: $0 -f [file path]')
    .demand('f')
    .default('f','/etc/stormtower/storm.json')
    .alias('f', 'file')
    .describe('f', 'location of stormtower configuration file')
    .argv

configJSON = ''

try
    fs = require("fs")
    configRaw = fs.readFileSync argv.file
    configJSON = JSON.parse configRaw
    console.log 'config file: ' + argv.file
    console.log configRaw.toString()
catch err
    console.log err.code + ' error while reading config file: ' + argv.file
    throw err

storm = require('./lib/stormtower')
stormtower = new storm configJSON
stormtower.start (output) ->
    if output instanceof Error
        console.log 'error while starting stormtower service, ' + output

