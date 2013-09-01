mongo = require "mongodb"
Server = mongo.Server
MongoDatabase = mongo.Db
BSON = mongo.BSONPure

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
        @_collection_access_error callback

  read:(id, callback)->
    @db.collection @name, (err, collection)=>

      unless err
        collection.findOne {"_id":new BSON.ObjectID(id)}, (err, item)=>
          unless err
            callback item
          else
            callback ("error":"Todo not found: #{id}")
            console.log "Error retrieving todo #{id}"
            console.log err

      else
        @_collection_access_error callback

  delete:(id, callback)->

    @db.collection @name, (err, collection)=>
      unless err
        collection.remove {"_id": new BSON.ObjectID(id)}, {safe:false}, (err, result)=>
          unless err
            console.log "Todo deleted"
            callback {}
          else
            console.log "Error deleting todo #{id}"
            callback ("error":"Couldn't delete todo #{id}")
      else
        @_collection_access_error callback

  update:(id, todo, callback)->

    @db.collection @name, (err, collection)=>

      unless err
        collection.update "_id": new BSON.ObjectID(id), todo, safe:false, (err, result)=>

          unless err
            console.log "#{result} document(s) updated"
            callback todo
          else
            console.log "Error updating todo #{err}"
            callback ("error":"Error updating todo #{id}")
      else
        @_collection_access_error callback

  create:(todo, callback)->
    @db.collection @name, (err, collection)=>

      unless err

        collection.insert todo, safe:false, (err, result)=>

          unless err
            console.log "Success: #{JSON.stringify(result[0])}"
            callback result[0]
          else
            callback ("error":"Couldn't create todo")

      else
        @_collection_access_error callback

  _collection_access_error:(callback)->
    console.log "Couldn't access #{@name} collection"
    console.log err
    callback ("error":"Couldn't connect to #{@name} collection")


module.exports = Database