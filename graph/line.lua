Line = Object:extend()

function Line:new(dot1, dot2)
    self.dot1 = dot1
    self.dot2 = dot2

    self.x1 = dot1.x
    self.y1 = dot1.y
    self.x2 = dot2.x
    self.y2 = dot2.y

    self.targetX2 = dot2.x
    self.targetY2 = dot2.y
end

function Line:setTarget(dot)
    self.targetX2 = dot.x
    self.targetY2 = dot.y
end

function Line:update(dt)
    self.x1 = self.dot1.x
    self.y1 = self.dot1.y
    
    local speed = 500 -- Adjust this value to control animation speed
    local dx = self.targetX2 - self.x2
    local dy = self.targetY2 - self.y2
    local distance = math.sqrt(dx * dx + dy * dy)
    
    if distance > 1 then
        local directionX = dx / distance
        local directionY = dy / distance
        self.x2 = self.x2 + directionX * speed * dt
        self.y2 = self.y2 + directionY * speed * dt
    else
        self.x2 = self.targetX2
        self.y2 = self.targetY2
    end
end

function Line:draw()
    love.graphics.line(self.x1, self.y1, self.x2, self.y2)
end
