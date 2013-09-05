express = require "express"
todos = require "./routes/todos"

class App

  constructor:()->

    @app = express()

    @app.configure ()=>

      @app.set "title", "TodoMVC"

      app.use express.methodOverride()

      # ## CORS middleware
      # see: http://stackoverflow.com/questions/7067966/how-to-allow-cors-in-express-nodejs
      allowCrossDomain = (req, res, next) ->
        res.header "Access-Control-Allow-Origin", "*"
        res.header "Access-Control-Allow-Methods", "GET,PUT,POST,DELETE"
        res.header "Access-Control-Allow-Headers", "Content-Type, Authorization"
        
        # intercept OPTIONS method
        if "OPTIONS" is req.method
          res.send 200
        else
          next()

      @app.use allowCrossDomain

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

