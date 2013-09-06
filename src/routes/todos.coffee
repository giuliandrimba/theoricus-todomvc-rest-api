Database = require "../database/database"
mongo = require "mongodb"
BSON = mongo.BSONPure

class Todos

  name:"todos"

  constructor:()->

    @db = new Database @name

  all:(req, res)=>
    @db.all (result, error)=>
      unless error
        for item in result
          item.id = item._id
          
        res.send result
      else
        res.send error

  read:(req, res)=>
    id = req.params.id
    console.log "Retrieving todo #{id}"

    @db.read id, (result, error)=>
      unless error
        result.id = result._id
        res.send result
      else
        res.send error


  create:(req, res)=>
    todo = req.body

    @db.create todo, (result, error)=>
      unless error
        result.id = result._id
        res.send result
      else
        res.send error

  update:(req, res)=>
    id = req.params.id
    todo = req.body

    console.log "Updating todo #{id}"
    console.log (JSON.stringify todo)

    @db.update id, todo, (result, error)=>
      unless error
        result.id = result._id
        res.send result
      else
        res.send error


  delete:(req, res)=>
    id = req.params.id
    console.log "Deleting todo #{id}"

    @db.delete id, (result, error)=>
      unless error
        result.id = result._id
        res.send result
      else
        res.send error

module.exports = new Todos