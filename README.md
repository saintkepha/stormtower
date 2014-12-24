Stormtower
==========



Synopsis
----------
Stormtower helps stormlight to interface with stormflash endpoints in realizing the defined functionality.

Stormlight relies on stormtower to reach out to stormflash endpoints by specifying the cname of the endpoint it wishes to configure. Stormflash endpoints can  be anywhere, sometimes running in a different network or geographical locations. Stormtower uses a secure communication channel provided by stormbolt, to communicate the stormflash endpoints.

It interfaces with stormlight on the north bound and with stormflash endpoints in the south bound. It interacts with Stormbolt relay server in east-west bound.

List of APIs
--------------

<table>
  <tr>
    <th>Verb</th><th>URI</th><th>Description</th>
  </tr>
  <tr>
    <td>HEAD</td><td>/minions</td><td>global md5 checksum of all stormflash agents's response objects</td>
  </tr>
  <tr>
    <td>GET</td><td>/minions</td><td>a list containing details about all stormflash agents connected to stormbolt server</td>
  </tr>
  <tr>
    <td>HEAD</td><td>/minions/:id</td><td>get md5 checksum of specific stormflash agents's response object</td>
  </tr>
  <tr>
    <td>GET</td><td>/minions/:id</td><td>details of a given stormflash agent</td>
  </tr>
</table>

###Get global md5 checksum

    Verb     URI              Description
    HEAD     /minions         global md5 checksum of all stormflash agents's response objects

On success it returns the global md5 checksum string in the Content-MD5 header field. This MD5 checksum string is generated from the response object of all stormflash agent connected to stormbolt server.

#### Response Header

    HTTP/1.1 200 OK
    X-Powered-By: Zappa 0.4.22
    Content-MD5: 3a37b15a63b8d282eaec9fe9827b5b04
    Content-Type: text/html; charset=utf-8
    Content-Length: 0
    Date: Mon, 07 Jul 2014 13:04:57 GMT
    Connection: keep-alive


###Get details about all stormflash agents

    Verb     URI              Description
    GET      /minions         list containing details about all stormflash agents connected to stormbolt server

On success it returns the list of response objects collected from GET /status endpoint of all stormflash agents connected to stormbolt server.

#### Response 

    [
      {
        "id": "30a2a131-f812-4666-bb69-c443f7e3a901",
        "instance": "0471ab4c-8277-4d14-9c39-d89bc40975eb",
        "activated": true,
        "running": true,
        "env": {
          "provider": "openstack",
          "skey": "4fbf0b56-44b7-45bf-97f0-c78119ef0ae4",
          "tracker": "https://stormtracker.dev.intercloud.net/",
          "token": "82335561-2ca2-46cb-892b-54ccee776cf8",
          "id": "30a2a131-f812-4666-bb69-c443f7e3a901",
          "bolt": {
            "beaconValidity": 45,
            "beaconRetry": 3,
            "beaconInterval": 10,
            "listenPort": 0,
            "allowedPorts": [
              5000
            ],
            "relayPort": 0,
            "allowRelay": false,
            "uplinkStrategy": "round-robin",
            "uplinks": [
              "stormtower.dev.intercloud.net"
            ]
          },
          "csr": "-----BEGIN CERTIFICATE REQUEST-----\nMIIDEzCCAfsCAQAwgc0xCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJDQTETMBEGA1UE\nBwwKRWwgU2VndW5kbzEbMBkGA1UECgwSQ2xlYXJQYXRoIE5ldHdvcmtzMQwwCgYD\nVQQLDANDUE4xLTArBgNVBAMMJDMwYTJhMTMxLWY4MTItNDY2Ni1iYjY5LWM0NDNm\nN2UzYTkwMTFCMEAGCSqGSIb3DQEJARYzMzBhMmExMzEtZjgxMi00NjY2LWJiNjkt\nYzQ0M2Y3ZTNhOTAxQGludGVyY2xvdWQubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOC\nAQ8AMIIBCgKCAQEAnMIIBwVqkvXdlYBqdjhZmK94eQSAZG5rVVziyyFlmr0TURRB\nAs8TbH4An3couugfYfXj8s+M+W6Iz1wQMQt4eiVvr8uEFOO8YKCowPz4R/JzXM6G\n84JTh5u0gBl+khl+4zUuQkcWwHbZFFGHV8ZtZPZ4GtNLmjsqcakBCZF70MAN2wQq\nB+gWoU6YSWvCGb8TDxnnRj3vwb07+H3WOZdTNdo5iBs+IaR4xatLrrSbIXzd8bGn\ne0WaXPszUWH4+7wUawN/lmn1h6eVu4mM5NTB/VqZGwWAyCRoo/Nty3710pN8+cvv\nzYPUowNJ9B9+xwrz47+lo0gPmQqn1vqHJd6QRQIDAQABoAAwDQYJKoZIhvcNAQEL\nBQADggEBACdZNl9p3MJwT4CwIdXTYIVIioiVkaiDhfECQ5XeS4q5AtpfYYayAURm\nlJGgk4bks5bQeyfsoHt6tRFOaF5T2YcgGbcAO7YP9E12teotEH0fpmG1lgGEouJP\nR2f2PprUkKQTXc/s34861LEZ2eTj1DC0hMVemYh5d1NqAvhwQzb7fM+b9Xj9GrZE\nv2fPsZ9tEvdDba6J9enFcpPlbgKBVcnImEVm2RHTnCmvY/tj2QBbJltQRyWHgOYA\nSUTamWPWA1fQO6sRhXuQosw7v+Q7HnbnUgwqsIaOwNY+JDrxJkjSX+cdxpcYQ6kN\nBD0rzPE1Ta3FuObdJf7Z5m1NumXkUlE=\n-----END CERTIFICATE REQUEST-----"
        },
        "haveCredentials": true,
        "config": {
          "repeatInterval": 25000,
          "insecure": true,
          "uplinks": [
            "stormtower.dev.intercloud.net"
          ],
          "uplinkStrategy": "round-robin",
          "allowRelay": false,
          "relayPort": 0,
          "allowedPorts": [
            5000
          ],
          "listenPort": 0,
          "beaconInterval": 10,
          "beaconRetry": 3,
          "beaconValidity": 45,
          "port": 5000,
          "logfile": "/var/log/stormflash.log",
          "datadir": "/var/stormflash",
          "repeatdelay": 5000
        },
        "os": {
          "tmpdir": "/lib/node_modules/stormflash",
          "endianness": "LE",
          "hostname": "kvm570",
          "type": "Linux",
          "platform": "linux",
          "release": "2.6.34.7",
          "arch": "ia32",
          "uptime": 33.254722954,
          "loadavg": [
            0,
            0,
            0
          ],
          "totalmem": 18446744073709548000,
          "freemem": 18446744073709548000,
          "cpus": [
            {
              "model": "Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz",
              "speed": 1999,
              "times": {
                "user": 27600,
                "nice": 0,
                "sys": 22900,
                "idle": 247000,
                "irq": 0
              }
            }
          ],
          "networkInterfaces": {
            "lo": [
              {
                "address": "127.0.0.1",
                "family": "IPv4",
                "internal": true
              }
            ],
            "wan0": [
              {
                "address": "10.101.1.7",
                "family": "IPv4",
                "internal": false
              }
            ]
          }
        },
        "uplink": {
          "host": "stormtower.dev.intercloud.net",
          "port": 443
        },
        "clients": [],
        "packages": [
          {
            "name": "stormflash",
            "version": "*",
            "source": "builtin",
            "type": "npm",
            "status": {
              "installed": true
            },
            "id": "07e33f9c-3a9a-40a3-a0e8-cd6ce0dc05ed"
          },
          {
            "name": "corenova",
            "version": "1.4.2",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "d7fc2e73-b8f1-4061-a106-66d821a2cdf9"
          },
          {
            "name": "ctwsd-linux-x86-gcc412-kernel26",
            "version": "2.00.0014",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "00b7250e-1b62-4224-b871-90a8e757b7e5"
          },
          {
            "name": "kav-sdk8-l1-clearpath-linux-i686",
            "version": "8.0.1.11",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "07b476a9-f7f5-4b12-8118-54beb41241c2"
          },
          {
            "name": "nodejs",
            "version": "0.10.13",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "e8028abf-144a-4c91-ba20-edde3fe64f45"
          },
          {
            "name": "openvpn",
            "version": "2.1.3",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "9faecb92-58e0-4cb7-aa67-a8913b064a25"
          },
          {
            "name": "uproxy",
            "version": "1.4.0",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "7c08f5b7-333a-4c4f-a7b4-20e9a6ea1407"
          }
        ],
        "services": [],
        "instances": []
      }
    ]

###Get md5 checksum of given stormflash agent

    Verb     URI                Description
    HEAD     /minions/:id       get md5 checksum of a specific stormflash agents's response object

On success it returns the md5 checksum string in the Content-MD5 header field. This MD5 checksum string is generated from the response object of given stormflash agent mentioned in the url.

#### Request URL

HEAD  /minions/30a2a131-f812-4666-bb69-c443f7e3a901


#### Response Header

    HTTP/1.1 200 OK
    X-Powered-By: Zappa 0.4.22
    Content-MD5: fe127619f30e4e269d7957d59261c4ff
    Content-Type: text/html; charset=utf-8
    Content-Length: 0
    Date: Mon, 07 Jul 2014 13:07:25 GMT
    Connection: keep-alive


###Get details about given stormflash agent

    Verb     URI                Description
    GET      /minions/:id       details of a given stormflash agent

On success it returns the the response object from GET /status endpoint of stormflash agent mentioned in the url. This contains metadata about the agent, network and OS relared info ialong with list of debian packages installed on it.

#### Request URL

GET  /minions/30a2a131-f812-4666-bb69-c443f7e3a901


#### Response 

    {
      "id": "30a2a131-f812-4666-bb69-c443f7e3a901",
      "instance": "0471ab4c-8277-4d14-9c39-d89bc40975eb",
      "activated": true,
      "running": true,
      "env": {
        "provider": "openstack",
        "skey": "4fbf0b56-44b7-45bf-97f0-c78119ef0ae4",
        "tracker": "https://stormtracker.dev.intercloud.net/",
        "token": "82335561-2ca2-46cb-892b-54ccee776cf8",
        "id": "30a2a131-f812-4666-bb69-c443f7e3a901",
        "bolt": {
          "beaconValidity": 45,
          "beaconRetry": 3,
          "beaconInterval": 10,
          "listenPort": 0,
          "allowedPorts": [
            5000
          ],
          "relayPort": 0,
          "allowRelay": false,
          "uplinkStrategy": "round-robin",
          "uplinks": [
            "stormtower.dev.intercloud.net"
          ]
        },
        "csr": "-----BEGIN CERTIFICATE REQUEST-----\nMIIDEzCCAfsCAQAwgc0xCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJDQTETMBEGA1UE\nBwwKRWwgU2VndW5kbzEbMBkGA1UECgwSQ2xlYXJQYXRoIE5ldHdvcmtzMQwwCgYD\nVQQLDANDUE4xLTArBgNVBAMMJDMwYTJhMTMxLWY4MTItNDY2Ni1iYjY5LWM0NDNm\nN2UzYTkwMTFCMEAGCSqGSIb3DQEJARYzMzBhMmExMzEtZjgxMi00NjY2LWJiNjkt\nYzQ0M2Y3ZTNhOTAxQGludGVyY2xvdWQubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOC\nAQ8AMIIBCgKCAQEAnMIIBwVqkvXdlYBqdjhZmK94eQSAZG5rVVziyyFlmr0TURRB\nAs8TbH4An3couugfYfXj8s+M+W6Iz1wQMQt4eiVvr8uEFOO8YKCowPz4R/JzXM6G\n84JTh5u0gBl+khl+4zUuQkcWwHbZFFGHV8ZtZPZ4GtNLmjsqcakBCZF70MAN2wQq\nB+gWoU6YSWvCGb8TDxnnRj3vwb07+H3WOZdTNdo5iBs+IaR4xatLrrSbIXzd8bGn\ne0WaXPszUWH4+7wUawN/lmn1h6eVu4mM5NTB/VqZGwWAyCRoo/Nty3710pN8+cvv\nzYPUowNJ9B9+xwrz47+lo0gPmQqn1vqHJd6QRQIDAQABoAAwDQYJKoZIhvcNAQEL\nBQADggEBACdZNl9p3MJwT4CwIdXTYIVIioiVkaiDhfECQ5XeS4q5AtpfYYayAURm\nlJGgk4bks5bQeyfsoHt6tRFOaF5T2YcgGbcAO7YP9E12teotEH0fpmG1lgGEouJP\nR2f2PprUkKQTXc/s34861LEZ2eTj1DC0hMVemYh5d1NqAvhwQzb7fM+b9Xj9GrZE\nv2fPsZ9tEvdDba6J9enFcpPlbgKBVcnImEVm2RHTnCmvY/tj2QBbJltQRyWHgOYA\nSUTamWPWA1fQO6sRhXuQosw7v+Q7HnbnUgwqsIaOwNY+JDrxJkjSX+cdxpcYQ6kN\nBD0rzPE1Ta3FuObdJf7Z5m1NumXkUlE=\n-----END CERTIFICATE REQUEST-----"
      },
      "haveCredentials": true,
      "config": {
        "repeatInterval": 25000,
        "insecure": true,
        "uplinks": [
          "stormtower.dev.intercloud.net"
        ],
        "uplinkStrategy": "round-robin",
        "allowRelay": false,
        "relayPort": 0,
        "allowedPorts": [
          5000
        ],
        "listenPort": 0,
        "beaconInterval": 10,
        "beaconRetry": 3,
        "beaconValidity": 45,
        "port": 5000,
        "logfile": "/var/log/stormflash.log",
        "datadir": "/var/stormflash",
        "repeatdelay": 5000
      },
      "os": {
        "tmpdir": "/lib/node_modules/stormflash",
        "endianness": "LE",
        "hostname": "kvm570",
        "type": "Linux",
        "platform": "linux",
        "release": "2.6.34.7",
        "arch": "ia32",
        "uptime": 33.254722954,
        "loadavg": [
          0,
          0,
          0
        ],
        "totalmem": 18446744073709548000,
        "freemem": 18446744073709548000,
        "cpus": [
          {
            "model": "Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz",
            "speed": 1999,
            "times": {
              "user": 27600,
              "nice": 0,
              "sys": 22900,
              "idle": 247000,
              "irq": 0
            }
          }
        ],
        "networkInterfaces": {
          "lo": [
            {
              "address": "127.0.0.1",
              "family": "IPv4",
              "internal": true
            }
          ],
          "wan0": [
            {
              "address": "10.101.1.7",
              "family": "IPv4",
              "internal": false
            }
          ]
        }
      },
      "uplink": {
        "host": "stormtower.dev.intercloud.net",
        "port": 443
      },
      "clients": [],
      "packages": [
        {
          "name": "stormflash",
          "version": "*",
          "source": "builtin",
          "type": "npm",
          "status": {
            "installed": true
          },
          "id": "07e33f9c-3a9a-40a3-a0e8-cd6ce0dc05ed"
        },
        {
          "name": "corenova",
          "version": "1.4.2",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "d7fc2e73-b8f1-4061-a106-66d821a2cdf9"
        },
        {
          "name": "ctwsd-linux-x86-gcc412-kernel26",
          "version": "2.00.0014",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "00b7250e-1b62-4224-b871-90a8e757b7e5"
        },
        {
          "name": "kav-sdk8-l1-clearpath-linux-i686",
          "version": "8.0.1.11",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "07b476a9-f7f5-4b12-8118-54beb41241c2"
        },
        {
          "name": "nodejs",
          "version": "0.10.13",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "e8028abf-144a-4c91-ba20-edde3fe64f45"
        },
        {
          "name": "openvpn",
          "version": "2.1.3",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "9faecb92-58e0-4cb7-aa67-a8913b064a25"
        },
        {
          "name": "uproxy",
          "version": "1.4.0",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "7c08f5b7-333a-4c4f-a7b4-20e9a6ea1407"
        }
      ],
      "services": [],
      "instances": []
    }



Usage
-----

### Code Snippet 1:

As Stormtower extends Stormbolt class, it inherits all the API endpoints, class methods and variables available in base class of stormbolt. When new Stormbolt clients connects to Stormbolt server, it is added as a new TowerMinion. TowerMinion monitors the Stormbolt client periodically to fetch the available plugins and services on it. Once the Stormbolt client moves to ready state, it is added to TowerRegistry.

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
    
    if require.main is module
        config = null
        storm = null
        agent = new StormTower config
        agent.run storm


### Code Snippet 2:

TowerMinion keeps monitoring the /status endpoint of each minion or Stormbolt client in specific interval of time. The output of the response is used, to generates md5 checksum of corresponding stormflash agent. Based on this md5 checksum Stormlight comes to know if packages got installed, uninstalled or updated in stormflash agent.

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

                    relay = @bolt.relay req
                    req.destroy()


### Code Snippet 3:

Defining API endpoints to access Stormtower services like fetching global and individual md5 checksum of Stormbolt client, metadata of all or specific bolt client.

    @get '/minions': ->
        @send tower.minions.list()

    @get '/minions/:id': ->
        match = tower.minions.get @params.id
        if match?
            @send match
        else
            @send 404


Copyrights and License
----------------------

LICENSE

MIT

COPYRIGHT AND PERMISSION NOTICE

Copyright (c) 2014-2015, Clearpath Networks, licensing@clearpathnet.com.

All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
