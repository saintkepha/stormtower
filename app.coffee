argv = require('optimist')
    .usage('Start stormtower with a configuration file.\nUsage: $0 -c <config file>')
    .demand('c')
    .default('c','/etc/stormstack/stormtower.json')
    .alias('c', 'file')
    .describe('c', 'location of stormtower configuration file')
    .argv

util = require('util')

try
    fs = require("fs")
    config = JSON.parse fs.readFileSync argv.file
    util.log 'stormtower config file: ' + argv.file

catch err
    util.log err.code + ' error while reading config file: ' + argv.file
    util.log "stormtower using default storm parameters..."
finally
    config.uid ?= 'stormtower'
    config.port ?= 8020
    util.log 'stormtower will run on port ' + config.port
    

# start the zappajs web server on desired port
{@app} = require('zappajs') config.port, ->
    @configObj = config
    @configure =>
      @use 'bodyParser', 'methodOverride', @app.router, 'static'
      @set 'basepath': '/v1.0'

    @configure
      development: => @use errorHandler: {dumpExceptions: on, showStack: on}
      production: => @use 'errorHandler'

    @enable 'serve jquery', 'minify'
    @include './src/api'


