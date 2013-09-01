mongo = require "mongodb"
Server = mongo.Server
MongoDatabase = mongo.Db

class Database

  constructor:(@name, @host = "localhost", @port=27017)->
    @server = new Server @host, @port, auto_reconnect:true
    @query = new MongoDatabase @name, @server, safe:false

    return @query


module.exports = Database