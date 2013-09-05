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

    @db.read id, (result)=>
      res.send result

  create:(req, res)=>
    todo = req.body

    @db.create todo, (result)=>
      res.send result

  update:(req, res)=>
    id = req.params.id
    todo = req.body

    console.log "Updating todo #{id}"
    console.log (JSON.stringify todo)

    @db.update id, todo, (result)=>
      res.send result


  delete:(req, res)=>
    id = req.params.id
    console.log "Deleting todo #{id}"

    @db.delete id, (result)=>
      res.send req.body

module.exports = new Todos