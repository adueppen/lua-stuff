-- LÖVE testing
function love.load()
  love.window.setMode(800, 600, {fullscreen=false, resizable=false, centered=true})
  love.window.setTitle('Pong')
  love.graphics.setBackgroundColor(0, 0, 0, 255)
  logo = love.graphics.newImage('res/pong.png')
  font = love.graphics.newImageFont('res/pongfont.png', ' abcdefghijklmnopqrstuvwxyz', 2)
  font:setFilter('nearest', 'nearest')
  love.graphics.setFont(font)
  time = 0
end

function love.update(dt)
  time = time + dt
end

function love.draw()
  love.graphics.scale(2, 2)
  love.graphics.push()
  love.graphics.scale(5, 5)
  love.graphics.print('pong', 21, 22)
  -- love.graphics.draw(logo, 105, 125)
  if time > .75 then
    if time > 1.5 then
      time = 0
    end
    love.graphics.pop()
  else
    love.graphics.pop()
    love.graphics.print('press the any key', 115, 185)
  end
end