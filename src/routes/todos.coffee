Database = require "../database/database"
mongo = require "mongodb"
BSON = mongo.BSONPure

class Todos

  name:"todos"

  constructor:()->

    @db = new Database @name

  all:(req, res)=>
    @db.all (result)=>
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.send result

  read:(req, res)=>
    id = req.params.id
    console.log "Retrieving todo #{id}"

    @db.read id, (result)=>
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.send result

  create:(req, res)=>
    todo = req.body

    @db.create todo, (result)=>
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.send result

  update:(req, res)=>
    id = req.params.id
    todo = req.body

    console.log "Updating todo #{id}"
    console.log (JSON.stringify todo)

    @db.update id, todo, (result)=>
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.send result


  delete:(req, res)=>
    id = req.params.id
    console.log "Deleting todo #{id}"

    @db.delete id, (result)=>
      res.setHeader("Access-Control-Allow-Origin", "*");
      res.send req.body

module.exports = new Todos