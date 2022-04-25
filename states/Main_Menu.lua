Main_Menu = Class{__includes = BaseState}

-- whether we're highlighting "Start" or "High Scores"
local highlighted = 1

function Main_Menu:enter(params)
    self.highScores = params.highScores
end

function Main_Menu:init()
    self.image=love.graphics.newImage('game bg2.png')
    self.vibo=love.graphics.newImage('Vibo.png')
end 

function Main_Menu:update(dt)

    --if love.keyboard.wasPressed('return') then
     --   gStateMachine:change('play',{
     --       highScores = self.highScores
     --   })
    --end

    --if love.keyboard.wasPressed('h') then
    --    gStateMachine:change('high-scores',{
    --        highScores = self.highScores
    --    })
    --end

     -- toggle highlighted option if we press an arrow key up or down
     if love.keyboard.wasPressed('up')then
        if highlighted == 1 then 
            highlighted = 5
        end 
         
        highlighted =(highlighted-1)%5
        --gSounds['paddle-hit']:play()
    end  

    if love.keyboard.wasPressed('down')then
        if highlighted == 4 then 
            highlighted = 0
        end 
        highlighted =(highlighted+1)%5
        --gSounds['paddle-hit']:play()
    end
    

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        --gSounds['confirm']:play()

        if highlighted == 1 then
            gStateMachine:change('play', {
                highScores = self.highScores
            })
        elseif  highlighted == 2 then
            gStateMachine:change('high-scores', {
                highScores = self.highScores
            })
        elseif highlighted ==  3 then
            gStateMachine:change('info', {
                highScores = self.highScores
            })
        elseif highlighted ==  4 then
            gStateMachine:change('credits', {
                highScores = self.highScores
            })


        end
    end

    -- we no longer have this globally, so include here
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end


end 


function Main_Menu:render()
    love.graphics.setFont(love.graphics.newFont('font.ttf',40))
    love.graphics.draw(self.image,0,0,0,1,1)
    --love.graphics.print("main-menu",400,400)
    --love.graphics.printf("VIBORA", 0, VIRTUAL_HEIGHT / 3,
    --VIRTUAL_WIDTH, 'center')
    love.graphics.draw(self.vibo,500-360,-200-50-60,0,1.75,1.75)

    -- instructions
 --   love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting 1, render that option blue
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 50-50,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 150-50,
        VIRTUAL_WIDTH, 'center')
    
        love.graphics.setColor(1, 1, 1, 1)
    if highlighted == 3 then
            love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("INSTRUCTIONS", 0, VIRTUAL_HEIGHT / 2 + 250-50,
            VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 4 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end

    love.graphics.printf("CREDITS", 0, VIRTUAL_HEIGHT / 2 + 350-50,
            VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

   -- love.graphics.print(highlighted,200,200)
end 