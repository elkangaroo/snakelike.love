local app = {}
app.version = 0.1
app.showdebug = false
app.showhelp = false
app.entities = {}
app.audio = {
  volume = 0.5,
  tracks = {
    '8bit_ninja.mp3',
    '8bit_jump_and_run.ogg'
  }
}
app.grid = {
  x = 32,
  y = 24
}

function love.load(...)
  app.grid.pixel = {
    width = love.graphics.getWidth() / app.grid.x,
    height = love.graphics.getHeight() / app.grid.y
  }

  app.entities.food = require('lib.entities.food')
  app.entities.food:load(app.grid)
  app.entities.snake = require('lib.entities.snake')
  app.entities.snake:load(app.grid)

  app.audio.background = love.audio.newSource('resources/sfx/' .. app.audio.tracks[math.random(#app.audio.tracks)], 'stream')
  app.audio.background:setVolume(app.audio.volume)
  app.audio.background:setLooping(true)

  love.audio.play(app.audio.background)
end

function love.update(dt)
  if app.entities.food:collide(app.entities.snake.position.x, app.entities.snake.position.y) then
    app.entities.food:setPosition()
    app.entities.snake:increaseSpeed()
  end

  app.entities.food:update(dt)
  app.entities.snake:update(dt)
end

function love.draw()
  if app.showdebug then
    app.debug()
  end

  if app.showhelp then
    love.graphics.push()
      love.graphics.setColor(85, 190, 240)
      love.graphics.printf([[
        arrows: move snake
        d     : toggle debug mode
        f     : toggle fullscreen
        m     : toggle music
        esc   : quit
      ]], love.graphics.getWidth() - 150 - 2, 2, 150, 'right')
   love.graphics.pop()
  end

  app.entities.food:draw()
  app.entities.snake:draw()
end

function love.focus(focused)
  app.audio.background:setVolume(app.audio.volume)
end

function love.quit()

end

function love.keypressed(key, unicode)
  if 'd' == key then
    app.showdebug = not app.showdebug
  end
  if 'f' == key then
    love.window.setFullscreen(not love.window.getFullscreen())
  end
  if 'h' == key then
    app.showhelp = not app.showhelp
  end
  if 'm' == key then
    app.audio.background:setVolume(app.audio.background:getVolume() == 0.0 and app.audio.volume or 0.0)
  end
  if 'escape' == key then
    love.event.push('quit')
  end

  app.entities.snake:keypressed(key, unicode)
end

function love.keyreleased(key, unicode)
  app.entities.snake:keyreleased(key)
end

function love.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)

end

function love.joystickpressed(joystick, button)

end

function love.joystickreleased(joystick, button)

end

function app.debug()
  love.graphics.push()
    love.graphics.setColor(85, 190, 240)
    love.graphics.print('FPS: ' .. love.timer.getFPS(), 2, 2)

    app.entities.food:debug()
    app.entities.snake:debug()
  love.graphics.pop()
end
