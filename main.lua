-- LÖVE testing
function love.load()
  love.window.setMode(800, 600, {fullscreen=false, resizable=false, centered=true})
  love.window.setTitle('Pong')
  love.keyboard.setKeyRepeat(true)
  font = love.graphics.newImageFont('res/pongfont.png', ' abcdefghijklmnopqrstuvwxyz<>-0123456789', 2)
  font:setFilter('nearest', 'nearest')
  love.graphics.setFont(font)
  love.graphics.setLineStyle('rough')
  love.graphics.setLineWidth(2)
  math.randomseed(os.time())
  for count = 1, math.random(10) do
    math.random()
  end
  time = 0
  state = 'title'
  scale = 2
  selectedOption = 1
  fgcolor = 8
  bgcolor = 1
  colorNameTable = {'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white'}
  colorTable = {{0, 0, 0}, {255, 0, 0}, {0, 255, 0}, {255, 255, 0}, {0, 0, 255}, {255, 0, 255}, {0, 255, 255}, {255, 255, 255}}
  player = {y = 80, points = 0}
  opponent = {y = 80, points = 0}
  ball = {x = 200, y = 150, angle = 0, speed = 4}
  ball.angle = math.random(145, 215)
end

function resizeWindow()
  love.window.setMode(400 * scale, 300 * scale)
end

function love.keypressed(key)
  if state == 'title' then
    if key == 'escape' then
      -- esc to quit on title screen
      love.event.quit()
    elseif key == 'o' then
      -- options
      state = 'options'
    else
      -- gamestart
      state = 'game'
    end
  elseif state == 'options' then
    if key == 'escape' then
      state = 'title'
    elseif key == 'down' then
      if selectedOption == 3 then
        selectedOption = 1
      else
        selectedOption = selectedOption + 1
      end
    elseif key == 'up' then
      if selectedOption == 1 then
        selectedOption = 3
      else
        selectedOption = selectedOption - 1
      end
    elseif selectedOption == 1 then
      scale = menuIterate(scale, key, 5)
      resizeWindow()
    elseif selectedOption == 2 then
      fgcolor = menuIterate(fgcolor, key, 8)
    elseif selectedOption == 3 then
      bgcolor = menuIterate(bgcolor, key, 8)
    end
  elseif state == 'game' then
    if key == 'escape' then
      state = 'title'
      player.y = 80
      opponent.y = 80
      player.points = 0
      opponent.points = 0
      ball = {x = 200, y = 150, angle = 0, speed = 4}
      ball.angle = math.random(145, 215)
    end
    -- maybe add a pause menu at some point
  end
end

function menuIterate(value, key, max)
  if key == 'right' then
    if value == max then
      return 1
    else
      return value + 1
    end
  elseif key == 'left' then
    if value == 1 then
      return max
    else
      return value - 1
    end
  end
end

function goodContrast()
  if fgcolor == 4 or bgcolor == 4 or bgcolor == 8 then
    return colorTable[7]
  else
    return colorTable[4]
  end
end

function love.update(dt)
  if state == 'title' then
    time = time + dt
  elseif state == 'game' then
    if love.keyboard.isDown('down') then
      if player.y <= 250 then
        player.y = player.y + 5
      end
    elseif love.keyboard.isDown('up') then
      if player.y >= 70 then
        player.y = player.y - 5
      end
    end
    if ball.y <= 70 or ball.y >= 285 then
      ball.angle = 540 - ball.angle
      ball.speed = ball.speed * -1
    end
    ball.x = ball.x + (math.cos(math.rad(ball.angle)) * ball.speed)
    ball.y = ball.y + (math.sin(math.rad(ball.angle)) * ball.speed)
  end
end

function love.draw()
  love.graphics.scale(scale, scale)
  love.graphics.setColor(colorTable[fgcolor])
  love.graphics.setBackgroundColor(colorTable[bgcolor])
  if state == 'title' then
    love.graphics.print('pong', 105, 105, 0, 5, 5)
    if time > .75 then
      if time > 1.5 then
        time = 0
      end
    else
      love.graphics.print('press the any key or', 100, 175)
      love.graphics.print('press o for options', 105, 195)
    end
  elseif state == 'options' then
    love.graphics.print('options - press esc to exit', 5, 5)
    love.graphics.line(5, 25, 278, 25)
    love.graphics.print('scale < ' .. scale .. ' >', 5, 30)
    love.graphics.print('foreground color < ' .. colorNameTable[fgcolor] .. ' >', 5, 45)
    love.graphics.print('background color < ' .. colorNameTable[bgcolor] .. ' >', 5, 60)
    if selectedOption == 1 then
      love.graphics.setColor(255, 255, 255)
      love.graphics.printf({colorTable[fgcolor], 'scale', goodContrast(), ' < ' .. scale .. ' >'}, 5, 30, love.graphics.getWidth())
    elseif selectedOption == 2 then
      love.graphics.setColor(255, 255, 255)
      love.graphics.printf({colorTable[fgcolor], 'foreground color', goodContrast(), ' < ' .. colorNameTable[fgcolor] .. ' >'}, 5, 45, love.graphics.getWidth())
    elseif selectedOption == 3 then
      love.graphics.setColor(255, 255, 255)
      love.graphics.printf({colorTable[fgcolor], 'background color', goodContrast(), ' < ' .. colorNameTable[bgcolor] .. ' >'}, 5, 60, love.graphics.getWidth())
    end
  elseif state == 'game' then
    love.graphics.rectangle('fill', 0, 60, 400, 10)
    love.graphics.print(player.points, 100, 2, 0, 4, 4)
    love.graphics.print(opponent.points, 260, 2, 0, 4, 4)
    love.graphics.rectangle('fill', 10, player.y, 10, 50)
    love.graphics.rectangle('fill', 380, opponent.y, 10, 50)
    love.graphics.rectangle('fill', ball.x, ball.y, 15, 15)
  end
end