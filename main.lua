-- LÖVE testing
function love.load()
  love.window.setMode(800, 600, {fullscreen=false, resizable=false, centered=true})
  love.window.setTitle('Pong')
  font = love.graphics.newImageFont('res/pongfont.png', ' abcdefghijklmnopqrstuvwxyz<>12345-', 2)
  font:setFilter('nearest', 'nearest')
  love.graphics.setFont(font)
  love.graphics.setLineStyle('rough')
  love.graphics.setLineWidth(2)
  time = 0
  state = 'title'
  scale = 2
  selectedOption = 1
  fgcolor = 8
  bgcolor = 1
  colorNameTable = {'black', 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan', 'white'}
  colorTable = {{0, 0, 0}, {255, 0, 0}, {0, 255, 0}, {255, 255, 0}, {0, 0, 255}, {255, 0, 255}, {0, 255, 255}, {255, 255, 255}}
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
      love.window.showMessageBox('Temp message, remove later', 'This will start the game')
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
      if key == 'right' then
        if scale == 5 then
          scale = 1
          resizeWindow()
        else
          scale = scale + 1
          resizeWindow()
        end
      elseif key == 'left' then
        if scale == 1 then
          scale = 5
          resizeWindow()
        else
          scale = scale - 1
          resizeWindow()
        end
      end
    elseif selectedOption == 2 then
      fgcolor = colorChange(fgcolor, key)
    elseif selectedOption == 3 then
      bgcolor = colorChange(bgcolor, key)
    end
  end
end

function colorChange(selColor, key)
  if key == 'right' then
    if selColor == 8 then
      return 1
    else
      return selColor + 1
    end
  elseif key == 'left' then
    if selColor == 1 then
      return 8
    else
      return selColor - 1
    end
  end
end

function goodContrast()
  if fgcolor == 4 or bgcolor == 4 then
    love.graphics.setColor(colorTable[7])
  else
    love.graphics.setColor(colorTable[4])
  end
end

function love.update(dt)
  if state == 'title' or state == 'options' then
    time = time + dt
  end
end

function love.draw()
  love.graphics.scale(scale, scale)
  love.graphics.setColor(colorTable[fgcolor])
  love.graphics.setBackgroundColor(colorTable[bgcolor])
  if state == 'title' then
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
    love.graphics.print('options - press esc to exit', 5, 5)
    love.graphics.line(5, 25, 278, 25)
    love.graphics.print('scale < ' .. scale .. ' >', 5, 30)
    love.graphics.print('foreground color < ' .. colorNameTable[fgcolor] .. ' >', 5, 45)
    love.graphics.print('background color < ' .. colorNameTable[bgcolor] .. ' >', 5, 60)
    -- more options
    if selectedOption == 1 then
      goodContrast()
      love.graphics.print(' < ' .. scale .. ' >', 55, 30)
      love.graphics.setColor(colorTable[fgcolor])
    elseif selectedOption == 2 then
      goodContrast()
      love.graphics.print(' < ' .. colorNameTable[fgcolor] .. ' >', 166, 45)
    elseif selectedOption == 3 then
      goodContrast()
      love.graphics.print(' < ' .. colorNameTable[bgcolor] .. ' >', 166, 60)
    end
  end
end