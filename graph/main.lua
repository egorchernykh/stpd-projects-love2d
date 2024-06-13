screen_width  = 900
screen_height = 500

function love.load()
    Object = require "classes/classic"
    require "dot"
    require "line"
    love.window.setMode(screen_width, screen_height)

    lines = {}
    
    dots = {}
    local dot = Dot(screen_width / 2, screen_height / 2, {1,1,1})
    table.insert(dots, dot)

    selectedFstDot = dot
    selectedSndDot = nil
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        local dotTouched = false
        for _, dot in ipairs(dots) do
            if dot:isMouseTouching() then
                selectDot(dot)
                dotTouched = true
                break
            end
        end
        if not dotTouched then
            addDot(x,y, {1,0,0})
        end
    end
end

function love.keypressed(key)
    if key == "return" then
        updateLine()
    end
end

function selectDot(dot)
    if selectedFstDot then
        selectedFstDot:setColor({1, 1, 1}) 
    end
    selectedFstDot = dot
    selectedFstDot:setColor({0, 1, 0}) 
end

function addDot(x, y)
    local dot = Dot(x, y, color)
    table.insert(dots, dot)
    if selectedFstDot then
        selectedSndDot = dot
        createLine(selectedFstDot, selectedSndDot)
    end
end

function createLine(fstDot, sndDot)
    local line = Line(fstDot, sndDot)
    table.insert(lines, line)
end

function updateLine()
    for _, line in ipairs(lines) do
        local newDot = dots[math.random(#dots)]
        line:setTarget(newDot)
    end
end

function love.update(dt)
    for _, line in ipairs(lines) do
        line:update(dt)
    end
end

function love.draw()
    for _, dot in ipairs(dots) do
        dot:draw()
    end
    for _, line in ipairs(lines) do
        line:draw()
    end
end
