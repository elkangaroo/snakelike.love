food = {}

local grid = nil

function food:load(thegrid)
  grid = thegrid

  self:setPosition()
end

function food:update(dt)
end

function food:draw()
  love.graphics.push()
    love.graphics.setColor(0, 255, 0)
    love.graphics.rectangle("fill", self.position.x * grid.pixel.width, self.position.y * grid.pixel.height, grid.pixel.width, grid.pixel.height)
  love.graphics.pop()
end

function food:keypressed(key, unicode)
end

function food:keyreleased(key, unicode)
end

function food:collide(x, y)
  if x == self.position.x and y == self.position.y then
    return true
  end

  return false
end

function food:setPosition(x, y)
  x = x or math.random(grid.x - 1)
  y = y or math.random(grid.y - 1)

  self.position = {
    x = x,
    y = y
  }
end

function food:debug()
  love.graphics.print('Pos (food): ' .. self.position.x .. ', ' .. self.position.y, 2, 42)
end

return food

