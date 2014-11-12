hippie = require('hippie')
hippie.assert.showDiff = false
#baseurl = 'http://192.168.122.138:8020'
baseurl = 'http://localhost:8020'


hippie()
.json()
.base baseurl
.get '/clients'
.expectStatus(200)
.expectBody([])
.end (err, res, body)->
	if err
		console.log "1. FAIL: Error is ", err
		#throw err
	else
		console.log "1. PASS: list of minions is empty"

hippie()
.json()
.base baseurl
.head '/clients'
.expectStatus(200)
.expectHeader('Content-MD5', 'd41d8cd98f00b204e9800998ecf8427e')
.end (err, res, body)->
	if err
		console.log "2. FAIL: Error is ",  err
		#throw err
	else
		console.log "2. PASS: check global MD5 checksum"

hippie()
.json()
.base baseurl
.get '/clients/abcd1234'
.expectStatus(404)
.expectBody("Not Found")
.end (err, res, body)->
	if err
		console.log "3. FAIL: Error is ", err
		#throw err
	else
		console.log "3. PASS: get MD5 checksum of invalid minion", body
	process.exit 0
	return

