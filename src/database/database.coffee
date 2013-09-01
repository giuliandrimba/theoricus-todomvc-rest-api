mongo = require "mongodb"
Server = mongo.Server
MongoDatabase = mongo.Db

class Database

  @new:(@name, @host = "localhost", @port=27017)->
    @server = new Server @host, @port, auto_reconnect:true
    @query = new MongoDatabase @name, @server, safe:true

    return @query

  @open:(callback)->
    @query.open (err, db)=>
      unless err
        console.log "Connected to todos_db database"
      else
        console.log "An error ocurred: #{err}"


module.exports = Database