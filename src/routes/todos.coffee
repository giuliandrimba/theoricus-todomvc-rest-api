Database = require "../database/database"
mongo = require "mongodb"
BSON = mongo.BSONPure

class Todos

  name:"todos"

  constructor:()->

    @db = new Database @name

  all:(req, res)=>
    @db.all (result)=>
      res.send result

  read:(req, res)=>
    id = req.params.id
    console.log "Retrieving todo #{id}"

    @db.collection @name, (err, collection)=>

      unless err
        collection.findOne {"_id":new BSON.ObjectID(id)}, (err, item)=>
          unless err
            res.send item
          else
            console.log "Error retrieving todo #{id}"
            console.log err

      else
        console.log "Couldn't access #{@name} collection"
        console.log err

  create:(req, res)=>
    todo = req.body

    @db.collection @name, (err, collection)=>

      unless err

        collection.insert todo, safe:false, (err, result)=>

          unless err
            console.log "Success: #{JSON.stringify(result[0])}"
            res.send result[0]
          else
            res.send "error":"An error has ocurred"

      else
        console.log "Error adding a todo: #{err}"

  update:(req, res)=>
    id = req.params.id
    todo = req.body

    console.log "Updating todo #{id}"
    console.log (JSON.stringify todo)

    @db.collection @name, (err, collection)=>

      unless err
        collection.update "_id": new BSON.ObjectID(id), todo, safe:false, (err, result)=>

          unless err
            console.log "#{result} document(s) updated"
            res.send todo
          else
            console.log "Error updating todo #{err}"
            res.send "error":"Error updating todo"
      else
        console.log "Couldn't access #{@name} collection"
        console.log err

  delete:(req, res)=>
    id = req.params.id
    console.log "Deleting todo #{id}"

    @db.collection @name, (err, collection)=>
      unless err
        collection.remove {"_id": new BSON.ObjectID(id)}, {safe:false}, (err, result)=>
          unless err
            console.log "#{result} document(s) deleted"
            res.send req.body
          else
            console.log "Error deleting todo #{id}"
            res.send "error":"Couldn't delete todo #{id}"
      else
        console.log "Couldn't access #{@name} collection"
        console.log err

module.exports = new Todos