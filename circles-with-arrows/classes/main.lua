local r1, r2

function love.load()
    Object = require "classic"

    local Shape =  require "shape" 
    local Rectangle = require "rectangle"
    local Circle = require "circle"

    shapes = {}
    r1 = Rectangle(math.random(0,400), math.random(0,400), 200, 50)
    r2 = Circle(math.random(0,400), math.random(0,400), 100)
    
    table.insert(shapes, r1)
    table.insert(shapes, r2)
end

function love.update(dt)
    for i,v in ipairs(shapes) do
        v:update(dt)
    end
end

function love.keypressed(key)
    if key == "space" then
        local r3
        if math.random(0,1) == 0 then
            r3 = Rectangle(math.random(0,400), math.random(0,400), 200, 50)
        else
            r3 = Circle(math.random(100, 400), math.random(100, 400), 100) 
        end
        table.insert(shapes, r3)
    end
end

function love.draw()
    for i,v in ipairs(shapes) do
        v:draw()
    end
end

