mongo = require "mongodb"
Server = mongo.Server
MongoDatabase = mongo.Db

class Database

  constructor:(@name, @host = "localhost", @port=27017)->
    @server = new Server @host, @port, auto_reconnect:true
    @db = new MongoDatabase @name, @server, safe:false

    @db.open (err, db)=>
      unless err
        console.log "Connected to todos_db database"
      else
        console.log "An error ocurred: #{err}"

  all:(callback)->
    @db.collection @name, strict:true, (err, collection)=>

      unless err
        collection.find().toArray (err, items)=>

          unless err
            callback items
          else
            callback ("error":"Couldn't retrive #{@name} collection")
            console.log "Couldn't retrive todos collection"

      else
        callback ("error":"Couldn't connect to #{@name} collection")

  read:(id, callback)->

  delete:(id, callback)->

  update:(id, callback)->

  create:(callback)->



module.exports = Database