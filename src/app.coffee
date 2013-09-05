express = require "express"
todos = require "./routes/todos"

class App

  constructor:()->

    @app = express()

    @app.set "title", "TodoMVC"

    @app.all "/api/*", (req, res, next) ->
      res.header "Access-Control-Allow-Origin", "*"
      res.header "Access-Control-Allow-Headers", "Cache-Control, Pragma, Origin, Authorization, Content-Type, X-Requested-With"
      res.header "Access-Control-Allow-Methods", "GET, PUT, POST"
      next()


    @app.use express.logger("dev")
    @app.use express.bodyParser()

    @routes()
    @server()

  routes:()->
    @app.get "/todos", todos.all
    @app.get "/todos/:id", todos.read
    @app.post "/todos", todos.create
    @app.put "/todos/:id", todos.update
    @app.delete "/todos/:id", todos.delete
  
  server:()->
    @app.listen(process.env.PORT || 5000)
    console.log "Listening on port 5000"

new App()

