Info = Class{__includes = BaseState}

function Info:enter(params)
    self.highScores = params.highScores
end

function Info:init()
    self.image=love.graphics.newImage('game bg2.png')
end 


function Info:update(dt)

    if love.keyboard.wasPressed('escape') then 
        love.event.quit()
    end 

    if love.keyboard.wasPressed('return') then 
        gStateMachine:change('Main_Menu', {
            highScores = self.highScores
        })
    end 
end

function Info:render()
    love.graphics.draw(self.image,0,0)
    love.graphics.setFont(love.graphics.newFont('font.ttf',35))
    love.graphics.setColor(0,1,1)
    love.graphics.printf("Instruction", 0, VIRTUAL_HEIGHT / 2 -300-60+40,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',25))
    love.graphics.printf("Up", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60+20,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("W/Arrow-Up", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60+20,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.printf("Down", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*2+20,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("S/Arrow-Down", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*2+20,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.printf("Left", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*3+20,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("A/Arrow-Left", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*3+20,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.printf("Right", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*4+20,
    VIRTUAL_WIDTH-300, 'center')
    love.graphics.printf("D/Arrow-Right", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*4+20,
    VIRTUAL_WIDTH+300, 'center')
    love.graphics.setFont(love.graphics.newFont('font.ttf',35))
    love.graphics.setColor(0,1,1)
    love.graphics.printf("Rules", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*5+20+30,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(1,1,1)
    love.graphics.setFont(love.graphics.newFont('font.ttf',24))
    love.graphics.printf("Taking steps from the classic Snake Game but with a potent and clever enemy alike", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*5+20+90+20,
    VIRTUAL_WIDTH, 'center')
    love.graphics.printf("Which targets your food and life even if it means its demise", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*5+20+90+40+20,
    VIRTUAL_WIDTH, 'center')
    love.graphics.printf("get your snake rolling and bring your best arcade skills to get survive and thrive!", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*5+20+90*2+10,
    VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(love.graphics.newFont('font.ttf',30))
    love.graphics.setColor(0,1,1)
    love.graphics.printf("Press Enter to return to the main menu!", 0, VIRTUAL_HEIGHT / 2 -300-60+40+60*5+20+90*3+10,
    VIRTUAL_WIDTH, 'center')


end 