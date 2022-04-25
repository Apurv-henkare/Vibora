--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the screen where we can view all high scores previously recorded.
]]

HighScoreState = Class{__includes = BaseState}

function HighScoreState:enter(params)
    self.highScores = params.highScores
end

function HighScoreState:init()
    self.image=love.graphics.newImage('game bg2.png')
end 

function HighScoreState:update(dt)
    -- return to the start screen if we press escape
    if love.keyboard.wasPressed('return') then
        --gSounds['wall-hit']:play()
        
        gStateMachine:change('Main_Menu', {
            highScores = self.highScores
        })
    end
end

function HighScoreState:render()
    love.graphics.draw(self.image,0,0)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',35))
   -- love.graphics.setFont(gFonts['large'])
    love.graphics.printf('High Scores', 0, 20, VIRTUAL_WIDTH, 'center')

    --love.graphics.setFont(gFonts['medium'])

    -- iterate over all high score indices in our high scores table
    i=1
    maxc=10
    --

    
    while(i<=10) do
        local count=0;
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'
       
        if i<4 then 
            love.graphics.setColor(0,1,1)
        else
            love.graphics.setColor(1,1,1)
        end
      --  if count == 1 then 
        -- score number (1-10)
            love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 
                60 + i * 45, 250, 'left')

            -- score name
            love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 
                60 + i * 45, 250, 'right')
            
            -- score itself
            love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2,
                60 + i * 45, 400, 'right') 
                --i=i+1
                
       -- else 
          --  maxc=maxc+1
       -- end 
        i=i+1
    end

   -- love.graphics.setFont(gFonts['small'])
   love.graphics.setColor(0,1,1)
    love.graphics.printf("Press Enter to return to the main menu!",
        0, VIRTUAL_HEIGHT - 100, VIRTUAL_WIDTH, 'center')
end
