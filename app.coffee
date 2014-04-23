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
    console.log configJSON
catch err
    console.error err.code + ' error while reading config file: ' + argv.file
    throw err

if configJSON.port?
    # start the zappajs web server on desired port
    {@app} = require('zappajs') configJSON.port, ->
        @configure =>
          @use 'bodyParser', 'methodOverride', @app.router, 'static'
          @set 'basepath': '/v1.0'
    
        @configure
          development: => @use errorHandler: {dumpExceptions: on, showStack: on}
          production: => @use 'errorHandler'
    
        @enable 'serve jquery', 'minify'
        @include './lib/proxy'
else
    console.error 'port is not defined in the config file ' + argv.file

