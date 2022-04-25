PlayState = Class{__includes = BaseState}


local enemy={{x=5,y=5}}
flag=0
function PlayState:enter(params)
    self.highScores = params.highScores
end

function PlayState:init()

  self.image=love.graphics.newImage('game bg.png')
  self.box=love.graphics.newImage('box.png')
  self.box_enemy=love.graphics.newImage('box-enemy.png')
  self.snake_face=love.graphics.newImage('Snake.png')
  self.enemy_face=love.graphics.newImage('Snake-enemy.png')
  self.food=love.graphics.newImage('food.png')
  math.randomseed(os.time())
  self.xfactor=0.38
  self.yfactor=0.38
    snakeSegments = {
        {x = 10,y = 5},
        {x = 9,y=5},
        {x = 8,y=5},
        {x = 7,y=5}
 
    }
    love.graphics.setFont(love.graphics.newFont(25))
    foodPosition = {
     }
     function moveFood()
     local possibleFoodPositions = {}
 
         for foodX = 5, 34 do
             for foodY = 4, 18 do
                 local possible = true
 
                 for segmentIndex, segment in ipairs(snakeSegments) do
                     if foodX == segment.x and foodY == segment.y  then
                         possible = false
                     end
                 end
 
                 if possible then
                     table.insert(possibleFoodPositions, {x = foodX, y = foodY})
                 end
             end
         end
 
         foodPosition=possibleFoodPositions[
             love.math.random(#possibleFoodPositions)
         ]
       end
       moveFood()
    timer=0
    directionQueue = {'right'}
 
 
    
    
end 

function PlayState:update(dt)

    if(flag==0)then
        store=(#snakeSegments)-4
    end
    if #snakeSegments == 0 then 
        gStateMachine:change('game-over',{score=store,highScores=self.highScores})
        snakeSegments = {
          {x = 10,y = 5},
          {x = 9,y=5},
          {x = 8,y=5},
          {x = 7,y=5}}


        enemy={{x=5,y=5}}
          store=0
          flag=0
          timer=0
           directionQueue = {'right'}
           moveFood()
    end
    timer = timer + dt+0.00020*3
    --  elseif(store>=20 and store<30)then
  --  timer = timer + dt+0.005
--  else
--    timer = timer + dt+0.01
--  end

   if   timer >=0.09 then
       timer = 0
      local can=true;
      --nextXPosition = snakeSegments[1].x
      --nextYPosition = snakeSegments[1].y
      


        if(flag==0)then
        nextXPosition = snakeSegments[1].x
        nextYPosition = snakeSegments[1].y

        nx=enemy[1].x
        ny=enemy[1].y




       if #directionQueue > 1 then
            table.remove(directionQueue, 1)
        end

        if directionQueue[1] == 'right' then
             nextXPosition = nextXPosition + 1
         elseif directionQueue[1] == 'left' then
             nextXPosition = nextXPosition - 1
         elseif directionQueue[1] == 'down' then
             nextYPosition = nextYPosition + 1
         elseif directionQueue[1] == 'up' then
             nextYPosition = nextYPosition - 1
         end

        


       --local nextXPosition = snakeSegments[1].x
       --local nextYPosition = snakeSegments[1].y


       table.insert(snakeSegments, 1, {
           x = nextXPosition, y = nextYPosition
       })
       table.insert(enemy, 1, {
        x = nx, y = ny
    })
       --table.remove(snakeSegments)
       --moveFood()
       if snakeSegments[1].x == foodPosition.x
       and snakeSegments[1].y == foodPosition.y then
          -- foodPosition = {
                --x = love.math.random(1,10),
              -- y = love.math.random(1,10),
          --  }
          moveFood()
        else
            table.remove(snakeSegments)
           -- table.remove(enemy)
        end
      
        --if enemy[1].x == foodPosition.x
       --and enemy[1].y == foodPosition.y then
          -- foodPosition = {
                --x = love.math.random(1,10),
              -- y = love.math.random(1,10),
          --  }

        if col2(foodPosition.x,foodPosition.y,nx,ny) then
          moveFood()
        else
          
            table.remove(enemy)
           -- table.remove(enemy)
        end
        --table.remove(enemy)
        

        if(snakeSegments[1].x>35 or snakeSegments[1].x<4 or snakeSegments[1].y<3 or snakeSegments[1].y>=19.5)then
          flag=1
        end


        for i=2,#snakeSegments do
            if  nextXPosition == snakeSegments[i].x
            and nextYPosition == snakeSegments[i].y then
             flag=1
            end    
        end

          

        

        --for segmentIndex, segment in pairs(snakeSegments) do
         ---   if (collision(segment,enemy)) then
         --     detected=true
            
         --   else 
         --     detected = false
         --   end
       -- end 
      if(distance(foodPosition.x,foodPosition.y,nx,ny)>8.4) then 
       player_enemy_angle=math.atan2((snakeSegments[1].y-1)*30-(enemy[1].y-1)*30,(snakeSegments[1].x-1)*30-(enemy[1].x-1)*30)
       self.xfactor=0.4
       self.yfactor=0.4
      else 
        player_enemy_angle=math.atan2((foodPosition.y-1)*30-(enemy[1].y-1)*30,(foodPosition.x-1)*30-(enemy[1].x-1)*30)
        self.xfactor=0.66
        self.yfactor=0.66
      end
       
       enemy_cos=math.cos(player_enemy_angle)
       enemy_sin=math.sin(player_enemy_angle)

       enemy[1].x=(enemy[1].x+self.xfactor*enemy_cos)
       enemy[1].y=(enemy[1].y+self.yfactor*enemy_sin)
       
      


      else
        table.remove(snakeSegments)
        table.remove(enemy)
      end
   end
   

   for i ,v in pairs(enemy)do
        
    for segmentIndex, segment in pairs(snakeSegments) do
     --for i ,v in pairs(enemy)do
      --print(segment.y,v.y)
     if(collision(segment,v))then 
       print(v.x,segment.x,v.y,segment.y)
       flag=1
     end 
   end 
   end 
   if (love.keyboard.wasPressed('right') or love.keyboard.wasPressed('d'))
   and directionQueue[#directionQueue] ~= 'right'
   and directionQueue[#directionQueue] ~= 'left' then
       table.insert(directionQueue, 'right')

   elseif (love.keyboard.wasPressed('left') or love.keyboard.wasPressed('a'))
   and directionQueue[#directionQueue] ~= 'left'
   and directionQueue[#directionQueue] ~= 'right' then
       table.insert(directionQueue, 'left')

   elseif (love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w'))
   and directionQueue[#directionQueue] ~= 'up'
   and directionQueue[#directionQueue] ~= 'down' then
       table.insert(directionQueue, 'up')

   elseif (love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s'))
   and directionQueue[#directionQueue] ~= 'down'
   and directionQueue[#directionQueue] ~= 'up' then
       table.insert(directionQueue, 'down')
   end

   
end



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


function PlayState:render()
   -- love.graphics.print("rfrf",500,500)
     love.graphics.setColor(1,1,1)
     love.graphics.draw(self.image,0,0)
     love.graphics.setFont(love.graphics.newFont('font.ttf',35))
--love.graphics.rectangle("fill",80-16,50-16,gray_w+32+32-4,gray_h+32+32-4)
  love.graphics.setColor(0.2,0.2,0.2)
 --love.graphics.setColor(42/255,88/255,25/255)
  --love.graphics.rectangle("fill",90,60,gray_w,gray_h)
 -- love.graphics.setColor(51/255,0/255,0/255)
 love.graphics.setColor(248/255,63/255,63/255)
  
  for i, v in pairs(enemy) do
   -- love.graphics.rectangle(
           -- 'fill',
           -- (v.x - 1) * cellSize,
           -- (v.y - 1) * cellSize,
           -- cellSize - 1,
           -- cellSize - 1,4)

      --if i>1 then 
        love.graphics.draw(self.box,(v.x - 1) * cellSize,
        (v.y - 1) * cellSize) 
      --else 
      --  love.graphics.draw(self.enemy_face,(v.x - 1) * cellSize,
      --  (v.y - 1) * cellSize,player_enemy_angle,1,1,15,15)
     -- end 
  end
    for segmentIndex, segment in pairs(snakeSegments) do
      if(flag==0)then
        love.graphics.setColor(141/255,197/255,62/255)
        --love.graphics.setColor(0, 0, 0)
        --love.graphics.rectangle(
          --    'fill',
          --    (segment.x - 1) * cellSize,
          --    (segment.y - 1) * cellSize,
          --    cellSize - 1,
          --    cellSize - 1,4)
        if segmentIndex>1 then 
          love.graphics.draw(self.box,(segment.x - 1) * cellSize,(segment.y - 1) * cellSize)
        else
          if directionQueue[#directionQueue] == 'right' then 
            love.graphics.draw(self.snake_face,(segment.x - 1) * cellSize+15,(segment.y - 1) * cellSize+15,((3*math.pi)/2),1,1,15,15
          )

        elseif directionQueue[#directionQueue] == 'left' then 
            love.graphics.draw(self.snake_face,(segment.x - 1) * cellSize+15,(segment.y - 1) * cellSize+15,(math.pi/2),1,1,15,15)
          --end 
        elseif directionQueue[#directionQueue] == 'down' then 
          love.graphics.draw(self.snake_face,(segment.x - 1) * cellSize,(segment.y - 1) * cellSize,0,1,1)
        elseif directionQueue[#directionQueue] == 'up' then 
          love.graphics.draw(self.snake_face,(segment.x - 1) * cellSize+15,(segment.y - 1) * cellSize+15,math.pi,1,1,15,15)
        end 
        end  
      
      else
        love.graphics.setColor(149/255,44/255,44/255)
      --end
        if segmentIndex > 1 then
          love.graphics.rectangle(
              'fill',
              (segment.x - 1) * cellSize,
              (segment.y - 1) * cellSize,
              cellSize - 1,
              cellSize - 1,4)
        end 
      end 
    end

    love.graphics.setColor(0/255,255/255,232/255,0.7)
    love.graphics.setLineWidth(10)
    --love.graphics.rectangle('fill',gray_w-30+90+30,60,10,gray_h+60)
    love.graphics.rectangle('line',90-5,60-5,gray_w+60-50,gray_h+60-25-25)
    --love.graphics.rectangle('fill',30+90-30,60-40,gray_w,60-20)
    --love.graphics.rectangle('fill',30+90-30,60+gray_h,gray_w,60-20+40)
    --love.graphics.clear(0,0,0)
    --love.graphics.clear(0,0,0)
    --love.graphics.setColor(0.2,0.2,0,2)
    --love.graphics.rectangle("fill",100,40,gray_w,gray_h)
    if(flag==0)then
    love.graphics.setColor(0, 1, 0.9)
    love.graphics.setColor(1,1,1)
    --love.graphics.setColor(175/255, 121/255, 14/255)
    ---love.graphics.rectangle(
       -- 'fill',
       -- (foodPosition.x - 1) * cellSize,
      --  (foodPosition.y - 1) * cellSize,
       -- cellSize - 1,
       -- cellSize - 1
   -- )
    love.graphics.draw(self.food,(foodPosition.x - 1) * cellSize-15,
        (foodPosition.y - 1) * cellSize-18,0,60/360,60/360,1,1)
  end
     love.graphics.setColor(0, 0.9, 0)
     --love.graphics.print(store,1100,100)
     love.graphics.setColor(0,0.9,0)
     --love.graphics.print("SCORE =",900,100)
     love.graphics.setColor(0,0.9,0)
    -- love.graphics.print("HIGHSCORE =",900,150)
     love.graphics.setColor(0, 0.9, 0)

    -- love.graphics.print(tostring(store),500,500)
     --love.graphics.print(highscore,1100,150)

     --controls of snake
     --love.graphics.setColor(1,0.5,1)
     --love.graphics.print("-------------CONTROLS-------------",900,230)
     --love.graphics.setColor(1,1,1)
     --love.graphics.print("Up Down         W,S",920,280)
     --love.graphics.print("Left Right        A,D",920,330)
     --love.graphics.setColor(1,0.5,1)
     --love.graphics.print("------------------------------------------",900,380)

    -- love.graphics.setColor(1,0.5,0)
     --love.graphics.print("Developed By ",1000,450)
    -- love.graphics.print("GameDevUtopia",1000,490)

     --love.graphics.print(tostring(detected),200,200)
     --love.graphics.setColor(1,1,1)
     --love.graphics.draw(img,900,450)

    -- love.graphics.rectangle("fill",enemy.x,enemy.y,enemy.width,enemy.height)

     --love.graphics.rectangle('line',snakeSegments[1].x,snakeSegments[1].y,30,30)
     if flag == 0 then
      --love.graphics.rectangle("fill",(snakeSegments[1].x - 1) * cellSize,
      --(snakeSegments[1].y - 1) * cellSize,
      --cellSize - 1,
      --cellSize - 1,4)
      --print(tostring(snakeSegments[1].x))
     end 

     if(flag==1)then
       love.graphics.setColor(1,0,0)
       love.graphics.print("GAME OVER!!!",380+100-5,280-50+100)
     --  love.graphics.print("Press R to restart!!!",350+100,280)
     end
     love.graphics.setColor(1,0.5,0)
     love.graphics.print(tostring("Past High Score : "..self.highScores[1].score),100,640)
     love.graphics.setColor(0, 0.9, 0)
     love.graphics.print(tostring("Current Score : "..tostring(store)),730,640)

end 

function distance(x1,y1,x2,y2)
    return math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
  
  end


function collision(v,e)
    return (v.x)<((e.x)+1) and
           ((v.x)+1)>(e.x) and
           ((v.y)*1)<((e.y+1)) and
           ((v.y)*1+1)>e.y
   end
  
function col2(x,y,nx,ny)
    return x<nx+1 and
           x+1>nx and 
           y<ny+1 and
           y+1>ny 
   end 
  