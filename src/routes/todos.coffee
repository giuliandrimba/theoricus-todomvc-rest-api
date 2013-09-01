mongo = require "mongodb"
Server = mongo.Server
MongoDatabase = mongo.Db

class Todos

  constructor:()->

    @server = new Server "localhost", 27017, auto_reconnect:true
    @db = new MongoDatabase "todos_db", @server, safe:true

    @db.open (err, db)=>
      unless err
        console.log "Connected to todos_db database"
      else
        console.log "An error ocurred: #{err}"

  all:(req, res)=>
    @db.collection "todos", strict:true, (err, collection)=>

      unless err
        collection.find().toArray (err, items)=>

          unless err
            res.send items
          else
            console.log "Couldn't retrive todos collection"

      else
        console.log "An error ocurred: #{err}"

  read:()=>
    console.log "READ"

  create:(req, res)=>
    todo = req.body

    @db.collection "todos", (err, collection)=>

      unless err

        collection.insert todo, safe:true, (err, result)=>

          unless err
            console.log "Success: #{JSON.stringify(result[0])}"
            res.send result[0]
          else
            res.send "error":"An error has ocurred"

      else
        console.log "Error adding a todo: #{err}"

  update:()=>
    console.log "UPDATE"

  delete:()=>
    console.log "DELETE"

module.exports = new Todos