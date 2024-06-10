Line = Object:extend()

function Line:new(dot1, dot2)
    self.dot1 = dot1
    self.dot2 = dot2
    self.x1 = dot1.x
    self.y1 = dot1.y
    self.x2 = dot2.x
    self.y2 = dot2.y

    self.color1 = dot1.color
    self.color2 = dot2.color
end

function Line:update(dt)
    self.x1 = self.dot1.x
    self.y1 = self.dot1.y
    self.x2 = self.dot2.x
    self.y2 = self.dot2.y

    self.color1 = self.dot1.color
    self.color2 = self.dot2.color
end

function Line:draw()
    local numSteps = 10 -- Количество шагов для создания градиента цвета
    local stepSize = 1 / numSteps

    for i = 1, numSteps do
        local t = i * stepSize
        local r = self.color1[1] * (1 - t) + self.color2[1] * t
        local g = self.color1[2] * (1 - t) + self.color2[2] * t
        local b = self.color1[3] * (1 - t) + self.color2[3] * t

        love.graphics.setColor(r, g, b)
        love.graphics.setLineWidth(5)
        love.graphics.line(
            self.x1 + (self.x2 - self.x1) * (i - 1) / numSteps,
            self.y1 + (self.y2 - self.y1) * (i - 1) / numSteps,
            self.x1 + (self.x2 - self.x1) * i / numSteps,
            self.y1 + (self.y2 - self.y1) * i / numSteps
        )
    end

    -- Восстановить цвет по умолчанию
    love.graphics.setColor(1, 1, 1)
end
