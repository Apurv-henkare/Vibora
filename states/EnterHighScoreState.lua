--[[
    GD50
    Breakout Remake

    -- EnterHighScoreState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Screen that allows us to input a new high score in the form of three characters, arcade-style.
]]

EnterHighScoreState = Class{__includes = BaseState}

-- individual chars of our string
local chars = {
    [1] = 48,
    [2] = 48,
    [3] = 48,
    [4] =48,
    [5] =48
}

-- char we're currently changing
local highlightedChar = 1

function EnterHighScoreState:enter(params)
    self.highScores = params.highScores
    self.score = params.score
    self.scoreIndex = params.scoreIndex
end

function EnterHighScoreState:init()
    self.image=love.graphics.newImage('game bg2.png')
end 


function EnterHighScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- update scores table
        local name = string.char(chars[1]) .. string.char(chars[2]) .. string.char(chars[3]).. string.char(chars[4]).. string.char(chars[5])
        
        local flag =0
        local update=0;
        local pos=0;
        local ss=0;
        for i=10,1,-1 do
            if name == self.highScores[i].name and self.score<= self.highScores[i].score then 
                flag=1
                break
            end 
            if name == self.highScores[i].name and self.score> self.highScores[i].score then 
                flag=2
                pos=i;
                ss=self.score
                break
            end 

        end

        if flag == 0 then 
            -- go backwards through high scores table till this score, shifting scores
            for i = 10, self.scoreIndex, -1 do
                self.highScores[i + 1] = {
                    name = self.highScores[i].name,
                    score = self.highScores[i].score
                }
            end

            self.highScores[self.scoreIndex].name = name
            self.highScores[self.scoreIndex].score = self.score

            -- write scores to file
            local scoresStr = ''

            for i = 1, 10 do
                scoresStr = scoresStr .. self.highScores[i].name .. '\n'
                scoresStr = scoresStr .. tostring(self.highScores[i].score) .. '\n'
            end

            love.filesystem.write('PICT.lst', scoresStr)

            --gStateMachine:change('high-scores', {
            --    highScores = self.highScores
           -- })
        end

        if flag == 2 then 
            

            self.highScores[pos].name = name
            self.highScores[pos].score = self.score

            
            table.sort(self.highScores,function (k1, k2) return k1.score > k2.score end )
            -- write scores to file
            local scoresStr = ''
            --end
            for i = 1, 10 do
                scoresStr = scoresStr .. self.highScores[i].name .. '\n'
                scoresStr = scoresStr .. tostring(self.highScores[i].score) .. '\n'
            end

            love.filesystem.write('PICT.lst', scoresStr)
        end 

        gStateMachine:change('high-scores', {
            highScores = self.highScores
        })
    end

        -- scroll through character slots
        if love.keyboard.wasPressed('left') and highlightedChar > 1 then
            highlightedChar = highlightedChar - 1
        -- gSounds['select']:play()
        elseif love.keyboard.wasPressed('right') and highlightedChar < 5  then
            highlightedChar = highlightedChar + 1
            --gSounds['select']:play()
        end

        -- scroll through characters
        if love.keyboard.wasPressed('up') then
            chars[highlightedChar] = chars[highlightedChar] + 1
            if chars[highlightedChar] > 57 then
                chars[highlightedChar] = 48
            end
        elseif love.keyboard.wasPressed('down') then
            chars[highlightedChar] = chars[highlightedChar] - 1
            if chars[highlightedChar] < 48 then
                chars[highlightedChar] = 57
            end
        end
end

function EnterHighScoreState:render()
     love.graphics.draw(self.image,0,0)
    --love.graphics.setFont(gFonts['medium'])
    love.graphics.setFont(love.graphics.newFont('font.ttf',40))
    love.graphics.printf('Your score: ' .. tostring(self.score), 0, 200,
        VIRTUAL_WIDTH, 'center')

  --  love.graphics.setFont(gFonts['large'])
    
    --
    -- render all three characters of the name
    --
    if highlightedChar == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[1]), VIRTUAL_WIDTH / 2 -50-55, VIRTUAL_HEIGHT / 2-25)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[2]), VIRTUAL_WIDTH / 2+0-55, VIRTUAL_HEIGHT / 2-25)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 3 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[3]), VIRTUAL_WIDTH / 2 + 50-55, VIRTUAL_HEIGHT / 2-25)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 4 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[4]), VIRTUAL_WIDTH / 2 + 100-55, VIRTUAL_HEIGHT / 2-25)
    love.graphics.setColor(1, 1, 1, 1)

    if highlightedChar == 5 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.print(string.char(chars[5]), VIRTUAL_WIDTH / 2 + 150-55, VIRTUAL_HEIGHT / 2-25)
    love.graphics.setColor(1, 1, 1, 1)
    
    --love.graphics.setFont(gFonts['small'])
    love.graphics.printf('Press Enter to confirm!', 0, VIRTUAL_HEIGHT - 250,
        VIRTUAL_WIDTH, 'center')
end