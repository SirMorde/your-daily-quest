require ("/libraries/AnAL")
require ("/libraries/hump/camera")
require ("/libraries/hump/gamestate")
require ("/libraries/hump/timer")
require ("/libraries/menu")
Menu = require "/libraries/menu"

function love.load(arg)
  --Import font
  font1 = love.graphics.newImageFont("images/fonts/imagefont.png",
    " abcdefghijklmnopqrstuvwxyz" ..
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
    "123456789.,!?-+/():;%&`'*#=[]\"")
  
  --love.graphics.setBackgroundColor(255, 255, 255)
  
  backgroundImage = love.graphics.newImage("/images/background_image.png")
  
  music = love.audio.newSource("/music/your_daily_quest_theme.mp3") -- if "static" is omitted, LÖVE will stream the file from disk, good for longer music tracks
    
  --Main Character
  player = {}
  player.costume = 1
  
  local costume1  = love.graphics.newImage("/images/characters/Blue-Ninja-SS.png")
  local costume2  = love.graphics.newImage("/images/characters/Blue-Speedster-SS.png")
  local costume3  = love.graphics.newImage("/images/characters/Orange-Ninja-SS.png")
  local costume4  = love.graphics.newImage("/images/characters/Puck-Guy-SS.png")
  local costume5  = love.graphics.newImage("/images/characters/Purple-Ninja-SS.png")
  local costume6  = love.graphics.newImage("/images/characters/Red-Ninja-SS.png")
  
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
  
  testmenu = Menu.new()
   testmenu:addItem{
      name = 'Start Game',
      action = function()
         -- do something
      end
   }
   testmenu:addItem{
      name = 'Options',
      action = function()
         -- do something
      end
   }
   testmenu:addItem{
      name = 'Quit',
      action = function()
         love.event.push('q')
      end
   }
end

-- For keyboard input
function love.keyreleased(key)
  if(key == " ") then
      if(player.costume == 6) then
      player.costume = 1
      else
      player.costume = player.costume + 1
      end
  end
end

function love.keypressed(key)
   testmenu:keypressed(key)
end

function love.update(dt)
  testmenu:update(dt)
  
  music:play()
  
  -- Draw the animation of the different costumes.
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
  
  local sx = love.graphics.getWidth() / backgroundImage:getWidth()
  local sy = love.graphics.getHeight() / backgroundImage:getHeight()
  love.graphics.draw(backgroundImage, 0, 0, 0, sx, sy) -- x: 0, y: 0, rot: 0, scale x and scale y
  
  testmenu:draw(10, 10)
  
  love.graphics.setFont(font1)
  
    love.graphics.printf(string.format("%.0f", remaining_time), 400, 150, 125, "center")
    love.graphics.printf("Press space to change costumes", 600, 500, 125, "center")
  --end
  
  if gameover == true then
    love.graphics.printf("GAME OVER M8", 400, 200, 125, "center")
  end

  anim:draw(496, 200, 0, 10, 10) 
  
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



