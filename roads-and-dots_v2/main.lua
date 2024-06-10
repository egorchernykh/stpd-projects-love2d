screen_width  = 900
screen_height = 500

function love.load()
    Object = require "classes/classic"
    require "line"
    require "dot"
    love.window.setMode(screen_width, screen_height)

    lines = {}
    dots = {}
    
    local dot = Dot(screen_width / 2, screen_height / 2, {1,1,1})
    table.insert(dots, dot)

    selectedDot = nil
    offsetX, offsetY = 0, 0
    dragging = false
end

function love.update(dt)
    if love.mouse.isDown(1) then
        local x, y = love.mouse.getPosition()

        if selectedDot then
            selectedDot.x = x - offsetX
            selectedDot.y = y - offsetY
            selectedDot.targetX = selectedDot.x
            selectedDot.targetY = selectedDot.y
            updateLines(selectedDot)
            dragging = true
        else
            dragging = false
        end
    else
        dragging = false
    end

    for _, dot in ipairs(dots) do
        dot:update(dt)
    end

    for _, line in ipairs(lines) do
        line:update(dt)
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        for _, dot in ipairs(dots) do
            if dot:isMouseTouching() then
                selectedDot = dot
                offsetX = x - dot.x
                offsetY = y - dot.y
                dragging = true
                return
            end
        end
        -- Если ни одна точка не выбрана, создаем новую точку
        addDot(x, y)
        if #dots > 1 then
            local lastDot = dots[#dots - 1]
            createLine(lastDot, dots[#dots])
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then
        selectedDot = nil
        dragging = false
    end
end

function love.keypressed(key)
    if key == "return" then
        for _, dot in ipairs(dots) do
            -- Установить новые случайные цели для перемещения
            dot.targetX = math.random(0, screen_width)
            dot.targetY = math.random(0, screen_height)
        end
    end
end

function createLine(dot1, dot2)
    local line = Line(dot1, dot2)
    table.insert(lines, line)
end

function addDot(x, y)
    local color = getColorForDot(#dots)
    local dot = Dot(x, y, color)
    table.insert(dots, dot)
end

function getColorForDot(index)
    -- Простой алгоритм для постепенного изменения цвета.
    local r = (index % 10) / 5
    local g = ((index + 3) % 5) / 5
    local b = ((index + 6) % 10) / 5
    return {r, g, b}
end

function updateLines(dot)
    for _, line in ipairs(lines) do
        if line.dot1 == dot then
            line.x1 = dot.x
            line.y1 = dot.y
        elseif line.dot2 == dot then
            line.x2 = dot.x
            line.y2 = dot.y
        end
    end
end

function love.draw()
    for i, line in ipairs(lines) do
        line:draw()
    end
    for i, dot in ipairs(dots) do 
        dot:draw()
    end
end
