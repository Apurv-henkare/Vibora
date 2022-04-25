

push= require 'push'

Class = require 'class'
require 'states/BaseState'
require 'states/Main_Menu'
require 'states/PlayState'
require 'states/GameOverState'
require 'states/EnterHighScoreState'
require 'states/HighScoreState'
require 'states/Credits'
require 'states/Info'
require 'StateMachine'

gray_w=810-70+200+20
gray_h=500-20+30
cellSize = 30
window_width=1300-150
window_height=750
VIRTUAL_WIDTH=window_width
VIRTUAL_HEIGHT=window_height


function love.load()
    push:setupScreen(1300-150,750,1300-150,750,{
        vsync = true,
        fullscreen =false,
        resizable = false,
        pixelperfect=false, highdpi = true ,stretched = false
    })

    gStateMachine = StateMachine {
        ['Main_Menu'] = function() return Main_Menu() end,
        ['play'] = function() return PlayState() end,
        ['game-over'] = function() return GameOverState() end,
        ['high-scores'] = function() return HighScoreState() end,
        ['enter-high-score'] = function() return EnterHighScoreState() end,
        ['info'] = function() return Info() end,
        ['credits']=function() return Credits() end

    }
    gStateMachine:change('Main_Menu', {
        highScores = loadHighScores()
    })

    img=love.graphics.newImage('snake2.png')

   love.keyboard.keysPressed = {}

end 

function love.resize(w,d)
    push:resize(w,d)
end 

function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
   -- if key == 'escape' then 
     --   love.event.quit()
      --end 
    
  
     -- if key == 'd'
     -- and directionQueue[#directionQueue] ~= 'right'
     -- and directionQueue[#directionQueue] ~= 'left' then
     --     table.insert(directionQueue, 'right')
  
     -- elseif key == 'a'
     -- and directionQueue[#directionQueue] ~= 'left'
     -- and directionQueue[#directionQueue] ~= 'right' then
      --    table.insert(directionQueue, 'left')
  
      --elseif key == 'w'
      ---and directionQueue[#directionQueue] ~= 'up'
     -- and directionQueue[#directionQueue] ~= 'down' then
      --    table.insert(directionQueue, 'up')
  
      --elseif key == 's'
     -- and directionQueue[#directionQueue] ~= 'down'
     -- and directionQueue[#directionQueue] ~= 'up' then
     --     table.insert(directionQueue, 'down')
     -- end
    
     
  
      
end

--[[
    A custom function that will let us test for individual keystrokes outside
    of the default `love.keypressed` callback, since we can't call that logic
    elsewhere by default.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end



function loadHighScores()
    love.filesystem.setIdentity('PICT_ACM_breakout')

    -- if the file doesn't exist, initialize it with some default scores
    if not love.filesystem.getInfo('PICT.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. '-----\n'
            scores = scores .. tostring(0 * 1000) .. '\n'
        end

        love.filesystem.write('PICT.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('PICT.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 5)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end

    return scores
end



function love.draw()
   -- push:start()
  --  love.graphics.draw(img,0,0)
    gStateMachine:render()
    --love.graphics.draw(img,0,0)
    
    --push:finish()
end 