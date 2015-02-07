require 'middleclass'
require 'gL2DMCStateGame'
require 'gL2DMCObjLevel'
require 'gL2DMCObjTower'
require 'gL2DMCObjCity'
require 'gL2DMCObjMissile'
require 'gL2DMCObjCursor'
require 'gL2DMCObjBomb'
require 'gL2DMCObjExplosion'


function love.load()
    GameStart = false;
end

function love.update(dt)
    if GameStart then
        world:update(dt)
        MCGame:gUpdate(dt)
    end
end

function love.draw()
    if GameStart then
        MCGame:gDraw()
    else
        love.graphics.setColor(255,255,255)
        love.graphics.print("Missile Command",350,250)
        love.graphics.print("Press Return/Enter To Enter",350,300)
        love.graphics.print("or ESC to quit",350,330)
    end
end

function love.keypressed(key)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
    if not GameStart and love.keyboard.isDown("return") then
       world = love.physics.newWorld(-800,-600,800,600,0,1.1)
       MCGame = GAME:new()
       GameStart = true
    elseif love.keyboard.isDown(" ") then
       MCGame:shoot()
    end 
end