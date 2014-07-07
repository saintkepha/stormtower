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
    <td>GET</td><td>/minions</td><td>a list containing details about all stormflash agents connected to stormbolt server</td>
  </tr>
  <tr>
    <td>HEAD</td><td>/minions/:id</td><td>get md5 checksum of specific stormflash agents's response object</td>
  </tr>
  <tr>
    <td>GET</td><td>/minions/:id</td><td>details of a given stormflash agent</td>
  </tr>
</table>

Get global md5 checksum
------------------------

    Verb   URI                              Description
    HEAD   /minions                         global md5 checksum of all stormflash agents's response objects

On success it returns the global md5 checksum string in the Content-MD5 header field. This MD5 checksum string is generated from the response object of all stormflash agent connected to stormbolt server.

### Response Header

    HTTP/1.1 200 OK
    X-Powered-By: Zappa 0.4.22
    Content-MD5: 3a37b15a63b8d282eaec9fe9827b5b04
    Content-Type: text/html; charset=utf-8
    Content-Length: 0
    Date: Mon, 07 Jul 2014 13:04:57 GMT
    Connection: keep-alive


Get details of all active stormflash agents
--------------------------------------------

    Verb   URI                              Description
    GET   /minions                          a list containing details about all stormflash agents connected to stormbolt server

On success it returns the list of response objects collected from GET /status endpoint of all stormflash agents connected to stormbolt server.

### Response 

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
            "name": "coffee-script",
            "version": "*",
            "source": "builtin",
            "type": "npm",
            "status": {
              "installed": true
            },
            "id": "ef45932a-77d9-4b13-a575-39df406799bc"
          },
          {
            "name": "npm",
            "version": "*",
            "source": "builtin",
            "type": "npm",
            "status": {
              "installed": true
            },
            "id": "a1ef350b-9524-42ac-9f86-a9b176c23d46"
          },
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
            "name": "apt",
            "version": "0.9.7.2",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "5db96247-9ea8-4cfd-8be0-f07ae309bfa1"
          },
          {
            "name": "busybox",
            "version": "1.17.2",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "0dcc349d-aa97-43cc-be8f-289ca2cc8805"
          },
          {
            "name": "condexec",
            "version": "0.1.1",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "a70b280a-a0ce-4069-a671-67edb16f3d24"
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
            "name": "curl",
            "version": "7.27.0",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "1a1ef46b-c5f2-4165-874a-052db9c863b4"
          },
          {
            "name": "dpkg",
            "version": "1.15.8.12",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "d1e2df83-4e31-414e-a9cd-59fedce7e27d"
          },
          {
            "name": "dropbear",
            "version": "0.51",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "00af7a06-66f8-4bac-9e2c-bfdc7e17359e"
          },
          {
            "name": "gettext",
            "version": "0.18.1.1",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "5ac67be8-5fb4-4ccc-8b4c-1a17a25e1796"
          },
          {
            "name": "gumbo-parser",
            "version": "1.0",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "4ec6ae75-e4f1-4f81-bd96-af467f782a7f"
          },
          {
            "name": "ifplugd",
            "version": "0.28",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "e500bb9c-9ed4-4e32-8fdc-ab31dace3c8b"
          },
          {
            "name": "iproute2",
            "version": "2.6.26",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "0cecaf7f-1cfb-42b8-9af3-a412f6d8341f"
          },
          {
            "name": "iptables",
            "version": "1.4.2",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "7ecaa104-1de8-4410-873a-290fd7737b03"
          },
          {
            "name": "jailer",
            "version": "0.1",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "51e18901-a390-45e8-a714-7e1a5d0854e7"
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
            "name": "libbind",
            "version": "6.0",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "f5d78cb3-3926-4a76-8203-ee64dea71dd7"
          },
          {
            "name": "libiconv",
            "version": "1.14",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "572fbb90-6d28-4da1-9071-0fd05764c16e"
          },
          {
            "name": "libmnl",
            "version": "1.0.3",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "36b13b34-b29c-4700-b53d-efea0ef3fd24"
          },
          {
            "name": "libnetfilter-conntrack",
            "version": "1.0.3",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "1f91afa9-150a-4e7e-a167-3d1359be0e2a"
          },
          {
            "name": "libnfnetlink",
            "version": "0.0.41",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "64096606-712e-4ed5-8287-922f82535c9e"
          },
          {
            "name": "libntlm",
            "version": "1.2",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "768653a1-ec11-4809-b525-a619a90db8f9"
          },
          {
            "name": "libpcap",
            "version": "1.2.1",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "2539d201-95e0-4cab-93dc-a40a3f0e0819"
          },
          {
            "name": "libtool",
            "version": "2.4",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "8b1602a9-05e3-4fef-96f3-e4c5987f4948"
          },
          {
            "name": "logger-daemon",
            "version": "1.2.12.0",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "1cd4f8c8-3a8a-43b2-b995-2447cfd7f8f5"
          },
          {
            "name": "net-snmp",
            "version": "5.5",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "09046e2b-d316-4089-8746-68842fbc8443"
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
            "name": "ntp",
            "version": "4.2.4p5",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "68f02764-3837-4fae-aca6-a16d42af28dd"
          },
          {
            "name": "openssl",
            "version": "1.0.1g",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "32414650-186e-494d-9fa3-8227527e20b7"
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
            "name": "perfecthash",
            "version": "20081027",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "fbfb06fa-488f-429d-b8c0-51379d5a5a14"
          },
          {
            "name": "procwatch",
            "version": "1.1",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "b110f6d8-a9f2-49c3-aae2-a9296ab8a0f7"
          },
          {
            "name": "spawnvpn",
            "version": "0.2.3",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "c02d5c8f-7e1c-4514-9d8d-d39bd5f19d37"
          },
          {
            "name": "stormflash",
            "version": "0.4.0",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "83310178-09e5-4f33-b32c-a3ce6db2e3d1"
          },
          {
            "name": "tcc",
            "version": "0.9.26",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "7ce60af0-4ffe-486e-8098-fec262ec6f54"
          },
          {
            "name": "uclibc",
            "version": "0.9.32",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "1ac3a454-49ff-484d-8fc7-d1cdc659dfc0"
          },
          {
            "name": "udev",
            "version": "167",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "fe81d48d-54fc-4136-9e7b-40a3278cd7be"
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
          },
          {
            "name": "zlib",
            "version": "1.2.3",
            "source": "builtin",
            "type": "dpkg",
            "status": {
              "installed": true
            },
            "id": "4a5e3e54-ec7b-4825-9627-51e6085a4faf"
          }
        ],
        "services": [],
        "instances": []
      }
    ]

Get md5 checksum of specific stormflash agent
----------------------------------------------

    Verb   URI                              Description
    HEAD   /minions/:id                     get md5 checksum of specific stormflash agents's response object

On success it returns the md5 checksum string in the Content-MD5 header field. This MD5 checksum string is generated from the response object of given stormflash agent mentioned in the url.

### Request URL

HEAD  /minions/30a2a131-f812-4666-bb69-c443f7e3a901


### Response Header

    HTTP/1.1 200 OK
    X-Powered-By: Zappa 0.4.22
    Content-MD5: fe127619f30e4e269d7957d59261c4ff
    Content-Type: text/html; charset=utf-8
    Content-Length: 0
    Date: Mon, 07 Jul 2014 13:07:25 GMT
    Connection: keep-alive


Get details of specific stormflash agent
-----------------------------------------

    Verb   URI                              Description
    GET    /minions/:id                     details of a given stormflash agent

On success it returns the the response object from GET /status endpoint of stormflash agent mentioned in the url.

### Request URL

GET  /minions/30a2a131-f812-4666-bb69-c443f7e3a901


### Response 

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
          "name": "coffee-script",
          "version": "*",
          "source": "builtin",
          "type": "npm",
          "status": {
            "installed": true
          },
          "id": "ef45932a-77d9-4b13-a575-39df406799bc"
        },
        {
          "name": "npm",
          "version": "*",
          "source": "builtin",
          "type": "npm",
          "status": {
            "installed": true
          },
          "id": "a1ef350b-9524-42ac-9f86-a9b176c23d46"
        },
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
          "name": "apt",
          "version": "0.9.7.2",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "5db96247-9ea8-4cfd-8be0-f07ae309bfa1"
        },
        {
          "name": "busybox",
          "version": "1.17.2",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "0dcc349d-aa97-43cc-be8f-289ca2cc8805"
        },
        {
          "name": "condexec",
          "version": "0.1.1",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "a70b280a-a0ce-4069-a671-67edb16f3d24"
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
          "name": "curl",
          "version": "7.27.0",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "1a1ef46b-c5f2-4165-874a-052db9c863b4"
        },
        {
          "name": "dpkg",
          "version": "1.15.8.12",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "d1e2df83-4e31-414e-a9cd-59fedce7e27d"
        },
        {
          "name": "dropbear",
          "version": "0.51",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "00af7a06-66f8-4bac-9e2c-bfdc7e17359e"
        },
        {
          "name": "gettext",
          "version": "0.18.1.1",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "5ac67be8-5fb4-4ccc-8b4c-1a17a25e1796"
        },
        {
          "name": "gumbo-parser",
          "version": "1.0",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "4ec6ae75-e4f1-4f81-bd96-af467f782a7f"
        },
        {
          "name": "ifplugd",
          "version": "0.28",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "e500bb9c-9ed4-4e32-8fdc-ab31dace3c8b"
        },
        {
          "name": "iproute2",
          "version": "2.6.26",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "0cecaf7f-1cfb-42b8-9af3-a412f6d8341f"
        },
        {
          "name": "iptables",
          "version": "1.4.2",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "7ecaa104-1de8-4410-873a-290fd7737b03"
        },
        {
          "name": "jailer",
          "version": "0.1",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "51e18901-a390-45e8-a714-7e1a5d0854e7"
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
          "name": "libbind",
          "version": "6.0",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "f5d78cb3-3926-4a76-8203-ee64dea71dd7"
        },
        {
          "name": "libiconv",
          "version": "1.14",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "572fbb90-6d28-4da1-9071-0fd05764c16e"
        },
        {
          "name": "libmnl",
          "version": "1.0.3",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "36b13b34-b29c-4700-b53d-efea0ef3fd24"
        },
        {
          "name": "libnetfilter-conntrack",
          "version": "1.0.3",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "1f91afa9-150a-4e7e-a167-3d1359be0e2a"
        },
        {
          "name": "libnfnetlink",
          "version": "0.0.41",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "64096606-712e-4ed5-8287-922f82535c9e"
        },
        {
          "name": "libntlm",
          "version": "1.2",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "768653a1-ec11-4809-b525-a619a90db8f9"
        },
        {
          "name": "libpcap",
          "version": "1.2.1",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "2539d201-95e0-4cab-93dc-a40a3f0e0819"
        },
        {
          "name": "libtool",
          "version": "2.4",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "8b1602a9-05e3-4fef-96f3-e4c5987f4948"
        },
        {
          "name": "logger-daemon",
          "version": "1.2.12.0",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "1cd4f8c8-3a8a-43b2-b995-2447cfd7f8f5"
        },
        {
          "name": "net-snmp",
          "version": "5.5",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "09046e2b-d316-4089-8746-68842fbc8443"
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
          "name": "ntp",
          "version": "4.2.4p5",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "68f02764-3837-4fae-aca6-a16d42af28dd"
        },
        {
          "name": "openssl",
          "version": "1.0.1g",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "32414650-186e-494d-9fa3-8227527e20b7"
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
          "name": "perfecthash",
          "version": "20081027",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "fbfb06fa-488f-429d-b8c0-51379d5a5a14"
        },
        {
          "name": "procwatch",
          "version": "1.1",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "b110f6d8-a9f2-49c3-aae2-a9296ab8a0f7"
        },
        {
          "name": "spawnvpn",
          "version": "0.2.3",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "c02d5c8f-7e1c-4514-9d8d-d39bd5f19d37"
        },
        {
          "name": "stormflash",
          "version": "0.4.0",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "83310178-09e5-4f33-b32c-a3ce6db2e3d1"
        },
        {
          "name": "tcc",
          "version": "0.9.26",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "7ce60af0-4ffe-486e-8098-fec262ec6f54"
        },
        {
          "name": "uclibc",
          "version": "0.9.32",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "1ac3a454-49ff-484d-8fc7-d1cdc659dfc0"
        },
        {
          "name": "udev",
          "version": "167",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "fe81d48d-54fc-4136-9e7b-40a3278cd7be"
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
        },
        {
          "name": "zlib",
          "version": "1.2.3",
          "source": "builtin",
          "type": "dpkg",
          "status": {
            "installed": true
          },
          "id": "4a5e3e54-ec7b-4825-9627-51e6085a4faf"
        }
      ],
      "services": [],
      "instances": []
    }

