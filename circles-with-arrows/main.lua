screen_width  = 900
screen_height = 500

function love.load()
    Object = require "classes/classic"
    require "circle"
    love.window.setMode(screen_width, screen_height)

    circles = {}
end

function love.update(dt)
    for _, circle in ipairs(circles) do
        circle:update(dt)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        local circle = Circle(x, y)
        table.insert(circles, Circle(x, y))
    end
end

function love.draw()
    for _, circle in ipairs(circles) do
        circle:draw()
    end
end