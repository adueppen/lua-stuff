-- LÖVE testing
function love.load()
  love.window.setMode(800, 600, {fullscreen=false, resizable=false, centered=true})
  love.window.setTitle('Pong')
  love.graphics.setBackgroundColor(0, 0, 0, 255)
  font = love.graphics.newImageFont('res/pongfont.png', ' abcdefghijklmnopqrstuvwxyz<>12345', 2)
  font:setFilter('nearest', 'nearest')
  love.graphics.setFont(font)
  time = 0
  state = 'title'
end

function love.keypressed(key)
  if key == 'escape' and state == 'title' then
    -- esc to quit on title screen
    love.event.quit()
  elseif key == 'escape' and state == 'options' then
    -- back to title
    state = 'title'
  elseif key == 'o' and state == 'title' then
    -- options
    state = 'options'
  elseif state == 'title' then
    -- gamestart
    state = 'game'
    love.window.showMessageBox('Temp message, remove later', 'This will start the game')
  end
end

function love.update(dt)
  if state == 'title' then
    time = time + dt
  end
end

function love.draw()
  if state == 'title' then
    love.graphics.scale(2, 2)
    love.graphics.push()
    love.graphics.scale(5, 5)
    love.graphics.print('pong', 21, 22)
    if time > .75 then
      if time > 1.5 then
        time = 0
      end
      love.graphics.pop()
    else
      love.graphics.pop()
      love.graphics.print('press the any key', 115, 185)
      love.graphics.print('press o for options', 105, 205)
    end
  elseif state == 'options' then
    love.graphics.scale(2, 2)
    love.graphics.print('scale <  >', 5, 5)
  end
end