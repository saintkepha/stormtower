stormtower
==========


*List of polling APIs*
========================

<table>
  <tr>
    <th>Verb</th><th>URI</th><th>Description</th>
  </tr>
  <tr>
    <td>HEAD</td><td>/minions</td><td>global md5 checksum of all stormflash agents's response objects</td>
  </tr>
  <tr>
    <td>GET</td><td>/minions</td><td>list of all stormflash agents along with their response objects</td>
  </tr>
  <tr>
    <td>GET</td><td>/minions:id/*</td><td>interface for forwarding the request to given stormflash agent</td>
  </tr>
  <tr>
    <td>POST</td><td>/minions:id/*</td><td>interface for forwarding the request to given stormflash agent</td>
  </tr>
  <tr>
    <td>PUT</td><td>/minions:id/*</td><td>interface for forwarding the request to given stormflash agent</td>
  </tr>
  <tr>
    <td>DELETE</td><td>/minions:id/*</td><td>interface for forwarding the request to given stormflash agent</td>
  </tr>
</table>

Get global md5 checksum
------------------------

    Verb   URI                              Description
    HEAD   /minions                         global md5 checksum of all stormflash agents's response objects

On success it returns the global md5 checksum string in the Content-MD5 header field.

### Response Header

HTTP/1.1 200 OK
X-Powered-By: Zappa 0.4.22
Content-MD5: 0f3f94260e4481e782754503ac2ece1f
Content-Type: text/html; charset=utf-8
Content-Length: 0
Date: Wed, 28 May 2014 06:12:43 GMT
Connection: keep-alive


Get details of all active stormflash agents
--------------------------------------------

    Verb   URI                              Description
    GET   /minions                          list of all stormflash agents along with their response objects

On success it returns the list of response objects from GET / endpoint collected from all active stormflash agents.

### Response Header

HTTP/1.1 200 OK
X-Powered-By: Zappa 0.4.22
Content-Type: application/json; charset=utf-8
Content-Length: 1802
ETag: "774575520"
Date: Wed, 28 May 2014 06:12:17 GMT
Connection: keep-alive

### Response 

  [
    {
      "id": "0af519e5-d485-4b46-8184-71a767f0b1d2",
      "instance": "18940dad-9249-49a6-bbe0-3fd12282329b",
      "activated": true,
      "running": true,
      "env": null,
      "config": {
        "insecure": true,
        "uplinks": [
          "stormbolt.dev.intercloud.net"
        ],
        "uplinkStrategy": "roundrobin",
        "allowRelay": false,
        "relayPort": 0,
        "allowedPorts": [
          5000,
          8000
        ],
        "listenPort": 0,
        "beaconInterval": 10,
        "beaconRetry": 2,
        "beaconValidity": 45,
        "port": 5000,
        "logfile": "/var/log/stormbolt.log",
        "datadir": "/var/stormstack",
        "repeatdelay": 5000
      },
      "os": {
        "tmpdir": "/lib/node_modules/stormbolt",
        "endianness": "LE",
        "hostname": "kvm570",
        "type": "Linux",
        "platform": "linux",
        "release": "2.6.34.7",
        "arch": "ia32",
        "uptime": 60609.931070117,
        "loadavg": [
          0,
          0,
          0
        ],
        "totalmem": 18446744073709548000,
        "freemem": 18446744073709548000,
        "cpus": [
          {
            "model": "Intel(R) Core(TM)2 Duo CPU T7700 @ 2.40GHz",
            "speed": 1999,
            "times": {
              "user": 6913900,
              "nice": 0,
              "sys": 1729900,
              "idle": 597201600,
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
              "address": "10.101.1.2",
              "family": "IPv4",
              "internal": false
            }
          ]
        }
      },
      "uplink": {
        "host": "stormbolt.dev.intercloud.net",
        "port": 443
      },
      "clients": [
        
      ]
    }
  ]

Get details of a given stormflash agent
----------------------------------------

    Verb   URI                              Description
    GET    /minions/:id/*                   interface for forwarding the request to given stormflash agent

The relative endpoint of a stormflash agent is postfixed in the url, for example /environment as in below case.

### Request URL

GET  /minions/0af519e5-d485-4b46-8184-71a767f0b1d2/environment


### Response 

  {
    "tmpdir": "/lib/node_modules/stormbolt",
    "endianness": "LE",
    "hostname": "kvm570",
    "type": "Linux",
    "platform": "linux",
    "release": "2.6.34.7",
    "arch": "ia32",
    "uptime": 91273.492737189,
    "loadavg": [
      0,
      0.00146484375,
      0
    ],
    "totalmem": 18446744073709548000,
    "freemem": 18446744073709548000,
    "cpus": [
      {
        "model": "Intel(R) Core(TM)2 Duo CPU     T7700  @ 2.40GHz",
        "speed": 1999,
        "times": {
          "user": 9547700,
          "nice": 0,
          "sys": 2588400,
          "idle": 900238600,
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
          "address": "10.101.1.2",
          "family": "IPv4",
          "internal": false
        }
      ]
    }
  }

Post input data to a given stormflash agent
--------------------------------------------

    Verb   URI                              Description
    POST   /minions/:id/*                   interface for forwarding the request to given stormflash agent

The relative endpoint of a stormflash agent is postfixed in the url, for example /packages as in below case.

### Request URL

GET  /minions/0af519e5-d485-4b46-8184-71a767f0b1d2/packages


### Request JSON

  {
    "name": "package-name",
    "version": "version-number",
    "source": "repo-url"
  }

### Response 

  {
      "id": "package-uuid",
      "name": "package-name",          
      "version": "version-number",
      "status":
      {
          "installed": true
      }
  }

