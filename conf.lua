local love = require "love"

function love.conf(app)
    app.window.width = 800
    app.window.height = 560
    app.window.minwidth = 800
    app.window.minheight = 560
    app.window.title = "Escape Room Game"
    app.window.resizable = true
end