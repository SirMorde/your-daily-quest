require ("AnAL")

function love.load(arg)
  --Import font
  medium = love.graphics.newImageFont("imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  
  love.graphics.setBackgroundColor(255, 255, 255)
  
  --Main Character
  player = {}
  player.costume = 1
  
  local costume1  = love.graphics.newImage("Blue-Ninja-SS.png")
  local costume2  = love.graphics.newImage("Blue-Speedster-SS.png")
  local costume3  = love.graphics.newImage("Orange-Ninja-SS.png")
  local costume4  = love.graphics.newImage("Puck-Guy-SS.png")
  local costume5  = love.graphics.newImage("Purple-Ninja-SS.png")
  local costume6  = love.graphics.newImage("Red-Ninja-SS.png")
  
  costume1:setFilter("nearest", "nearest")
  costume2:setFilter("nearest", "nearest")
  costume3:setFilter("nearest", "nearest")
  costume4:setFilter("nearest", "nearest")
  costume5:setFilter("nearest", "nearest")
  costume6:setFilter("nearest", "nearest")
  
  anim1 = newAnimation(costume1, 32, 32, .25, 0)
  anim2 = newAnimation(costume2, 32, 32, .25, 0) 
  anim3 = newAnimation(costume3, 32, 32, .25, 0)
  anim4 = newAnimation(costume4, 32, 32, .25, 0)  
  anim5 = newAnimation(costume5, 32, 32, .25, 0)
  anim6 = newAnimation(costume6, 32, 32, .25, 0)
  
  --Timer
  remaining_time = 5
  gameover = false
  
  --[[ Leftover code from shooter game
  if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
  hero = {} -- new table for the hero
  hero.x = 300 -- x,y coordinates of the hero
  hero.y = 450
  hero.width = 30
  hero.height = 15
  hero.speed = 150
  hero.shots = {} -- holds our fired shots

  enemies = {}
  for i=0,7 do
    local enemy = {}
    enemy.width = 40
    enemy.height = 30
    enemy.x = i * (enemy.width + 60) + 100
    enemy.y = enemy.height + 100
    table.insert(enemies, enemy)
  end
    ]]
end

-- For keyboard input
function love.keyreleased(key)
  if(key == " ") then
      player.costume = player.costume + 1
  end
end

function love.update(dt)
  -- Draw the animation at (496, 100).
  if(player.costume == 1) then
    anim = anim1 
  elseif(player.costume == 2) then
    anim = anim2
  elseif(player.costume == 3) then
    anim = anim3
  elseif (player.costume == 4) then
    anim = anim4
  elseif (player.costume == 5) then
    anim = anim5
  elseif (player.costume == 6) then
    anim = anim6
    player.costume = 1
  end
  
  -- Updates the animation. (Enables frame changes)
  anim:update(dt) 

  --Setting game over
  remaining_time = remaining_time - dt 
  if remaining_time <= 0 then
      gameover = true
  end
end

function love.draw()
  love.graphics.setFont(medium)
  
  --remainingtimetrunc = re
  --if remaining_time%1 == 0 then
    love.graphics.printf(remaining_time, 200, 300, 125, "center")
    love.graphics.printf("Press space to change costumes", 600, 500, 125, "center")
  --end
  
  if gameover == true then
    love.graphics.printf("GAME OVER M8", 200, 200, 125, "center")
  end

  anim:draw(496, 100, 0, 10, 10) 
end

function shoot()
  if #hero.shots >= 5 then return end
  local shot = {}
  shot.x = hero.x+hero.width/2
  shot.y = hero.y
  table.insert(hero.shots, shot)
end

-- Collision detection function.
-- Checks if a and b overlap.
-- w and h mean width and height.
function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)
  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end
