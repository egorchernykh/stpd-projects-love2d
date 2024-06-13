--dot.lua

Dot = Object:extend()

function Dot:new(x, y, color)
    self.x = x
    self.y = y
    self.radius = 5
    self.color = color or {1, 1, 1}
end

function Dot:update(dt)

end

function Dot:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, self.radius)
    love.graphics.setColor(1, 1, 1) 
end

function Dot:isMouseTouching()
    local x, y = love.mouse.getPosition()
    return math.abs(x - self.x) < 5 and math.abs(y - self.y) < 5
end

function Dot:setColor(color)
    self.color = color
end