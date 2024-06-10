Circle = Object:extend()

function Circle:new(x, y)
    self.x = x 
    self.y = y
    self.radius = 20
    self.scale = 0.1
    self.target_scale = 1
end

function Circle:draw()
    love.graphics.circle("fill", self.x, self.y, self.radius * self.scale)
end

function Circle:update(dt)
    if self.scale < self.target_scale then
        self.scale = self.scale + dt * 6
        if self.scale > self.target_scale then
            self.scale = self.target_scale
        end
    end
end