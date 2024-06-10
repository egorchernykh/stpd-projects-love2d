Dot = Object:extend()

function Dot:new(x, y, color)
    self.x = x
    self.y = y
    self.targetX = x
    self.targetY = y
    self.speed = 400 -- Скорость перемещения точки
    self.color = color or {1, 1, 1}
end

function Dot:update(dt)
    if self.x ~= self.targetX or self.y ~= self.targetY then
        local dx = self.targetX - self.x
        local dy = self.targetY - self.y
        local distance = math.sqrt(dx * dx + dy * dy)

        if distance < self.speed * dt then
            self.x = self.targetX
            self.y = self.targetY
        else
            self.x = self.x + (dx / distance) * self.speed * dt
            self.y = self.y + (dy / distance) * self.speed * dt
        end
    end
end

function Dot:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.x, self.y, 5)
    love.graphics.setColor(1, 1, 1) -- Вернуть цвет по умолчанию
end

function Dot:isMouseTouching()
    local x, y = love.mouse.getPosition()
    return math.abs(x - self.x) < 5 and math.abs(y - self.y) < 5
end
