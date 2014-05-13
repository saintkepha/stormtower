stormtower
==========


*List of polling APIs*
========================

<table>
  <tr>
    <th>Verb</th><th>URI</th><th>Description</th>
  </tr>
  <tr>
    <td>HEAD</td><td>/</td><td>global md5 checksum of stormflash endpoint's response objects</td>
  </tr>
  <tr>
    <td>HEAD</td><td>/?cnames[]=:id1&cnames[]=:id2</td><td>global md5 checksum generated from response objects of given stormflash endpoints</td>
  </tr>
  <tr>
    <td>GET</td><td>/</td><td>list of stormflash endpoints along with their response objects</td>
  </tr>
  <tr>
    <td>GET</td><td>/?cnames[]=:id1&cnames[]=:id2</td><td>list of given stormflash endpoints along with their response objects</td>
  </tr>
</table>

Get global md5 checksum of all stormflash endpoints
----------------------------------------------------

    Verb   URI                              Description
    HEAD   /                                global md5 checksum of stormflash endpoint's response objects

### Response Header

       HTTP/1.1 200 OK
       X-Powered-By: Zappa 0.4.22
       Content-MD5: d41d8cd98f00b204e9800998ecf8427e
       Content-Type: text/html; charset=utf-8
       Content-Length: 0
       Date: Tue, 13 May 2014 10:31:35 GMT
       Connection: keep-alive


Get md5 checksum of specific stormflash endpoints
--------------------------------------------------

    Verb   URI                              Description
    HEAD   /?cnames[]=:id1&cnames[]=:id2    global md5 checksum of stormflash endpoint's response objects

### Response Header

       HTTP/1.1 200 OK
       X-Powered-By: Zappa 0.4.22
       Content-MD5: e2bc7fd34f64070cac2201adbc5c423b
       Content-Type: text/html; charset=utf-8
       Content-Length: 0
       Date: Tue, 13 May 2014 10:31:39 GMT
       Connection: keep-alive


Get details of all stormflash endpoints
----------------------------------------

    Verb   URI                              Description
    GET    /                                get details of all stormflash endpoints

### Response Header

    HTTP/1.1 200 OK
    X-Powered-By: Zappa 0.4.22
    Content-Type: application/json; charset=utf-8
    Content-Length: 77
    Date: Tue, 13 May 2014 10:55:20 GMT
    Connection: keep-alive

### Response 

    {
      "getGlobalChecksum": "d41d8cd98f00b204e9800998ecf8427e",
      "agents": [
        {
          "cname": "0109476b-b563-4845-b662-28b12ed1c57d",
          "response": {
            "registryId": "UUID",
            "serialKey": "",
            "environment": {
              "launchMethod": "manual or cloudio",
              "provider": "openstack/gce/aws/custom",
              "nodeVersion": "",
              "npmVersion": "",
              "coffeeVersion": "",
              "pkgManager": {
                "name": "<name>",
                "version": "<version>"
              }
            },
            "os": {
              "tmpdir": "",
              "endianness": "BE or LE",
              "hostname": "",
              "type": "os name",
              "platform": "os platform",
              "arch": " cpu architecture",
              "release": " OS release",
              "loadavg": [
                
              ],
              "totalmem": 1024,
              "freemem": 256,
              "cpus": [
                {
                  "model": "",
                  "speed": "",
                  "times": {
                    "user": 252020,
                    "nice": 0,
                    "sys": 30340,
                    "idle": 2324234234,
                    "irq": 0
                  }
                }
              ],
              "networkInterfaces": [
                {
                  "<name>": [
                    {
                      "address": "",
                      "family": "IPv4 or IPv6",
                      "internal": true
                    }
                  ]
                }
              ],
              "gateway": {
                "address": "",
                "family": "IPV4 or IPv6",
                "interface": ""
              }
            },
            "packages": [
              {
                "id": "",
                "name": "",
                "version": "",
                "source": "<package manager or builtin>",
                "stormflash": true
              }
            ],
            "plugins": [
              {
                "id": "",
                "name": "",
                "version": "",
                "services": [
                  
                ]
              }
            ],
            "services": [
              {
                "id": "",
                "name": "",
                "status": "running|stopped"
              }
            ]
          },
          "checksum": "be1e620cffb05d8fd4ab01702b914b78",
          "lastUpdated": "4:13:2014 10:55:11 UTC"
        },
        {
          "cname": "45cec9c9-a541-4453-b238-fc04cd353a42",
          "response": {
            "registryId": "UUID",
            "serialKey": "",
            "environment": {
              "launchMethod": "manual or cloudio",
              "provider": "openstack/gce/aws/custom",
              "nodeVersion": "",
              "npmVersion": "",
              "coffeeVersion": "",
              "pkgManager": {
                "name": "<name>",
                "version": "<version>"
              }
            },
            "os": {
              "tmpdir": "",
              "endianness": "BE or LE",
              "hostname": "",
              "type": "os name",
              "platform": "os platform",
              "arch": " cpu architecture",
              "release": " OS release",
              "loadavg": [
                
              ],
              "totalmem": 1024,
              "freemem": 256,
              "cpus": [
                {
                  "model": "",
                  "speed": "",
                  "times": {
                    "user": 252020,
                    "nice": 0,
                    "sys": 30340,
                    "idle": 2324234234,
                    "irq": 0
                  }
                }
              ],
              "networkInterfaces": [
                {
                  "<name>": [
                    {
                      "address": "",
                      "family": "IPv4 or IPv6",
                      "internal": true
                    }
                  ]
                }
              ],
              "gateway": {
                "address": "",
                "family": "IPV4 or IPv6",
                "interface": ""
              }
            },
            "packages": [
              {
                "id": "",
                "name": "",
                "version": "",
                "source": "<package manager or builtin>",
                "stormflash": true
              }
            ],
            "plugins": [
              {
                "id": "",
                "name": "",
                "version": "",
                "services": [
                  
                ]
              }
            ],
            "services": [
              {
                "id": "",
                "name": "",
                "status": "running|stopped"
              }
            ]
          },
          "checksum": "a68051d239f643e989b321e3161486be",
          "lastUpdated": "4:13:2014 10:55:11 UTC"
        }
      ]
    }


Get details of specific stormflash endpoints
---------------------------------------------

    Verb   URI                              Description
    GET    /?cnames[]=:id1&cnames[]=:id2    get details of specific stormflash endpoints

### Response Header

    HTTP/1.1 200 OK
    X-Powered-By: Zappa 0.4.22
    Content-Type: application/json; charset=utf-8
    Content-Length: 77
    Date: Tue, 13 May 2014 10:55:28 GMT
    Connection: keep-alive

### Response 

    {
      "getGlobalChecksum": "d41d8cd98f00b204e9800998ecf8427e",
      "agents": [
        {
          "cname": "0109476b-b563-4845-b662-28b12ed1c57d",
          "response": {
            "registryId": "UUID",
            "serialKey": "",
            "environment": {
              "launchMethod": "manual or cloudio",
              "provider": "openstack/gce/aws/custom",
              "nodeVersion": "",
              "npmVersion": "",
              "coffeeVersion": "",
              "pkgManager": {
                "name": "<name>",
                "version": "<version>"
              }
            },
            "os": {
              "tmpdir": "",
              "endianness": "BE or LE",
              "hostname": "",
              "type": "os name",
              "platform": "os platform",
              "arch": " cpu architecture",
              "release": " OS release",
              "loadavg": [
                
              ],
              "totalmem": 1024,
              "freemem": 256,
              "cpus": [
                {
                  "model": "",
                  "speed": "",
                  "times": {
                    "user": 252020,
                    "nice": 0,
                    "sys": 30340,
                    "idle": 2324234234,
                    "irq": 0
                  }
                }
              ],
              "networkInterfaces": [
                {
                  "<name>": [
                    {
                      "address": "",
                      "family": "IPv4 or IPv6",
                      "internal": true
                    }
                  ]
                }
              ],
              "gateway": {
                "address": "",
                "family": "IPV4 or IPv6",
                "interface": ""
              }
            },
            "packages": [
              {
                "id": "",
                "name": "",
                "version": "",
                "source": "<package manager or builtin>",
                "stormflash": true
              }
            ],
            "plugins": [
              {
                "id": "",
                "name": "",
                "version": "",
                "services": [
                  
                ]
              }
            ],
            "services": [
              {
                "id": "",
                "name": "",
                "status": "running|stopped"
              }
            ]
          },
          "checksum": "be1e620cffb05d8fd4ab01702b914b78",
          "lastUpdated": "4:13:2014 10:55:11 UTC"
        },
        {
          "cname": "45cec9c9-a541-4453-b238-fc04cd353a42",
          "response": {
            "registryId": "UUID",
            "serialKey": "",
            "environment": {
              "launchMethod": "manual or cloudio",
              "provider": "openstack/gce/aws/custom",
              "nodeVersion": "",
              "npmVersion": "",
              "coffeeVersion": "",
              "pkgManager": {
                "name": "<name>",
                "version": "<version>"
              }
            },
            "os": {
              "tmpdir": "",
              "endianness": "BE or LE",
              "hostname": "",
              "type": "os name",
              "platform": "os platform",
              "arch": " cpu architecture",
              "release": " OS release",
              "loadavg": [
                
              ],
              "totalmem": 1024,
              "freemem": 256,
              "cpus": [
                {
                  "model": "",
                  "speed": "",
                  "times": {
                    "user": 252020,
                    "nice": 0,
                    "sys": 30340,
                    "idle": 2324234234,
                    "irq": 0
                  }
                }
              ],
              "networkInterfaces": [
                {
                  "<name>": [
                    {
                      "address": "",
                      "family": "IPv4 or IPv6",
                      "internal": true
                    }
                  ]
                }
              ],
              "gateway": {
                "address": "",
                "family": "IPV4 or IPv6",
                "interface": ""
              }
            },
            "packages": [
              {
                "id": "",
                "name": "",
                "version": "",
                "source": "<package manager or builtin>",
                "stormflash": true
              }
            ],
            "plugins": [
              {
                "id": "",
                "name": "",
                "version": "",
                "services": [
                  
                ]
              }
            ],
            "services": [
              {
                "id": "",
                "name": "",
                "status": "running|stopped"
              }
            ]
          },
          "checksum": "a68051d239f643e989b321e3161486be",
          "lastUpdated": "4:13:2014 10:55:11 UTC"
        }
      ]
    }


