-- LÖVE testing
function love.load()
  love.window.setMode(400, 300, {fullscreen=false, resizable=false, centered=true})
  love.window.setTitle('Pong')
  love.graphics.setBackgroundColor(0, 0, 0, 255)
  logo = love.graphics.newImage('res/pong.png')
  anykey = love.graphics.newImage('res/anykey.png')
  time = 0
end

function love.update(dt)
  time = time + dt
end

function love.draw()
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.draw(logo, 105, 125)
  if time > .75 then
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.rectangle('fill', 115, 185, 170, 10)
    if time > 1.4 then
      time = 0
    end
  else
    love.graphics.draw(anykey, 115, 185)
  end
  
end