snake = {}

local grid = nil
local delta = 0
local deltaspeed = 0.5
local maxspeed = 120
local minspeed = 1

function snake:load(thegrid)
  grid = thegrid

  self.length = 1
  self.speed = 5
  self.direction = 'right'
  self.position = {
    x = math.random(grid.x),
    y = math.random(grid.y)
  }
end

function snake:update(dt)
  if delta < (1 / self.speed) then
    delta = delta + dt
    return
  end

  if 'up' == self.direction then
    self.position.y = (self.position.y - 1) < 0 and (grid.y - 1) or (self.position.y - 1)
  elseif 'down' == self.direction then
    self.position.y = (self.position.y + 1) > (grid.y - 1) and 0 or (self.position.y + 1)
  elseif 'left' == self.direction then
    self.position.x = (self.position.x - 1) < 0 and (grid.x - 1) or (self.position.x - 1)
  elseif 'right' == self.direction then
    self.position.x = (self.position.x + 1) > (grid.x - 1) and 0 or (self.position.x + 1)
  end

  delta = 0
end

function snake:draw()
  love.graphics.push()
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", self.position.x * grid.pixel.width, self.position.y * grid.pixel.height, grid.pixel.width, grid.pixel.height)
  love.graphics.pop()
end

function snake:keypressed(key, unicode)
  if 'up' == key and 'down' ~= self.direction then
    self.direction = 'up'
  elseif 'down' == key and 'up' ~= self.direction then
    self.direction = 'down'
  elseif 'left' == key and 'right' ~= self.direction then
    self.direction ='left'
  elseif 'right' == key and 'left' ~= self.direction then
    self.direction = 'right'
  end

  if '+' == key and self.speed < maxspeed then
    self:increaseSpeed()
  end
  if '-' == key and self.speed > minspeed then
    self:decreaseSpeed()
  end
end

function snake:keyreleased(key, unicode)
end

function snake:increaseSpeed()
  self.speed = self.speed + deltaspeed
end

function snake:decreaseSpeed()
  self.speed = self.speed - deltaspeed
end

function snake:debug()
  love.graphics.print('Speed: ' .. self.speed, 2, 14)
  love.graphics.print('Pos (snake): ' .. self.position.x .. ', ' .. self.position.y, 2, 28)
end

return snake

