local love = require "love"

function love.conf(app)
    app.window.width = 800
    app.window.height = 600
    app.window.title = "Escape Room Game"
    app.window.resizable = true
end