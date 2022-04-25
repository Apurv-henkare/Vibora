Credits = Class{__includes = BaseState}

function Credits:init()
    self.image=love.graphics.newImage('game bg2.png')
end 


function Credits:update(dt)

    if love.keyboard.wasPressed('escape') then 
        love.event.quit()
    end 

    if love.keyboard.wasPressed('return') then 
        gStateMachine:change('Main_Menu', {
            highScores = loadHighScores()
        })
    end

end

function Credits:render()
    love.graphics.draw(self.image,0,0)
    love.graphics.setColor(0,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',30))
    love.graphics.printf("Game Developed By", 0, VIRTUAL_HEIGHT / 2 -300-60,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',28))
    love.graphics.printf("Apurv Henkare Rutuja Kakad", 0, VIRTUAL_HEIGHT / 2 -230-10-60,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',30))
    love.graphics.printf("Game Design By", 0, VIRTUAL_HEIGHT / 2 -230+100-60,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',28))
    love.graphics.printf("Om Shinde", 0, VIRTUAL_HEIGHT / 2 -230+100+60-60,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(0,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',30))
    love.graphics.printf("Game Testers", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90-60,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',26))
    love.graphics.printf("Srushti", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60-60+30,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("Aryajeet", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50-60+30,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("Tejas", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50*2-60+30,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("Somya", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50*3-60+30,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("Aditya", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50*3-60+30,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.printf("Atharva ", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50*0-60+30,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.printf("Pranav", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50*1-60+30,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.printf("Omkar", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50*2-60+30,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.setColor(0,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',30))
    love.graphics.printf("Press Enter to return to the main menu!", 0, VIRTUAL_HEIGHT / 2 -230+100+60+90+60+50*4-60+50,
    VIRTUAL_WIDTH, 'center')
   -- love.graphics.print("credits",500,500)
end 