#! /usr/bin/env coffee

express  = require 'express'
path     = require 'path'

{log, error} = console

start = (port=8000) ->
  root = path.resolve __dirname, '../'

  log "Creating server."

  app = express()

  log "Starting server."

  app.use(express.static(root))
  app.listen(port)

  log "Serving #{root} at http://localhost:#{port}"

start()
