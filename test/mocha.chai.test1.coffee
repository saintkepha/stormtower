request = require("request")
expect = require("chai").expect

StormTower = require("./../src/stormtower.coffee")

describe "StormTower", ->
    it "1. check stormtower config", ->

        ST = new StormTower
        expect(ST.config).to.contain.key('logfile')
        expect(ST.config).to.be.an('object')
        expect(ST.config.uplinks).to.be.empty
        expect(ST.config.ca).to.be.a('string')
        expect(ST.config.key).to.be.a('string')
        expect(ST.config.cert).to.be.a('string')

    it "2. checks if minions list is empty", (done) ->
        request "http://localhost:8020/clients", (error, response, body) ->
            jsonbody = JSON.parse body
            expect(response.statusCode).to.equal(200)
            expect(jsonbody).to.be.empty
            #expect(jsonbody).to.be.an('object')
            done()

    it "3. checks global MD5 checksum", (done) ->
        request.head "http://localhost:8020/clients", (error, response, body) ->
            expect(response.statusCode).to.equal(200)
            expect(response.headers["content-md5"]).to.be.a('string')
            done()
        return

    it "4. checks details of invalid minion", (done) ->
        request "http://localhost:8020/clients/abcd1234", (error, response, body) ->
            expect(response.statusCode).to.equal(404)
            expect(body).to.equal("Not Found")
            done()

    it "5. checks MD5 checksum of invalid minion", (done) ->
        request.head "http://localhost:8020/clients/abcd1234", (error, response, body) ->
            expect(response.statusCode).to.equal(404)
            done()
    return

