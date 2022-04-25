--[[
    GD50
    Breakout Remake

    -- GameOverState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The state in which we've lost all of our health and get our score displayed to us. Should
    transition to the EnterHighScore state if we exceeded one of our stored high scores, else back
    to the StartState.
]]

GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
    self.score = params.score
    self.highScores = params.highScores
end

function GameOverState:init()
    self.image=love.graphics.newImage('game bg2.png')
end 

function GameOverState:update(dt)
    if love.keyboard.isDown('return') then
        -- see if score is higher than any in the high scores table
        local highScore = false
        
        -- keep track of what high score ours overwrites, if any
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = self.highScores[i].score or 0
            if self.score > score then
                highScoreIndex = i
                highScore = true
                
            end
        end

        if highScore then
            --gSounds['high-score']:play()
            gStateMachine:change('enter-high-score', {
                highScores = self.highScores,
                score = self.score,
                scoreIndex = highScoreIndex
            }) 
        else 
            gStateMachine:change('Main_Menu', {
                highScores = self.highScores
            }) 
        end
    end

    if love.keyboard.isDown('escape') then
        love.event.quit()
    end
end

function GameOverState:render()
   -- love.graphics.setFont(gFonts['large'])
    love.graphics.draw(self.image,0,0)
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',35))
    love.graphics.printf('GAME OVER', 0, window_height/ 3,window_width, 'center')
   -- love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Final Score: ' .. tostring(self.score), 0, window_height/ 2,
        window_width, 'center')
        love.graphics.setColor(0,1,1)
    love.graphics.printf('Press Enter!', 0, window_height - window_height / 4-65,
        window_width, 'center')
end