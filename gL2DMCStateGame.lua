class = require 'middleclass'

GAME = class('GAME')
--to do score, quick fixes
function GAME:initialize()

    self.gBMissles = {}
    self.gBombs = {} 
    self.gExplosions = {}
    
    self.nIntervalTick = 0
    
    self.mCursor = CURSOR:new(400,300)
    self.Tower = self:buildTowers()
    
    self.gCLevel = 1
    self.mLevel = LEVEL:new(self.gCLevel)
    
    self.temp = 0
    
    self.Cities = self:buildCities()
    self.TDirection = {0,105,176,247,554,625,696,390,790}
    
    self.Score = 0
end

function GAME:gUpdate(dt)
    
    --Launching Missiles
    self.nIntervalTick = self.nIntervalTick+dt
    if self.mLevel.numMissiles > self.mLevel.misCount and self.nIntervalTick > self.mLevel.MInterval then
        self.nIntervalTick = 0
        self:launchWave()
    end
    
    --Next Wave or Game Over
    if self.mLevel.numMissiles == self.mLevel.misCount and table.getn(self.gBMissles) == 0 then
        if table.getn(self.Cities) ~= 0 then
            self:NextLevel()
        else
            self:GameOver()
        end
    end
    
    for q, tower in pairs (self.Tower) do
        for k,missile in pairs(self.gBMissles) do
            if tower.gShape:testPoint(0,0,0,missile.gBody:getX(),missile.gBody:getY())then
                local e = EXPLOSION:new(world,missile.gBody:getX(),missile.gBody:getY() - 10)
                table.insert(self.gExplosions,e)      
                missile.gBody:destroy()
                table.remove(self.gBMissles,k)
                self.mLevel.destMissiles = self.mLevel.destMissiles + 1
                tower.bombCount = 0
            end
        end
    end
    
    --Check City vs Missile
    for ck,city in pairs(self.Cities) do
        for k,missile in pairs(self.gBMissles) do            
            if city.gShape:testPoint(0,0,0,missile.gBody:getX(),missile.gBody:getY()) then
                local e = EXPLOSION:new(world,missile.gBody:getX(),missile.gBody:getY() - 10)
                table.insert(self.gExplosions,e)      
                missile.gBody:destroy()
                table.remove(self.gBMissles,k)
                self.mLevel.destMissiles = self.mLevel.destMissiles + 1
                local number = city.xPos
                table.remove(self.TDirection,number)
                city.gBody:destroy()
                table.remove(self.Cities,ck)
                break                
            end
        end
    end
    -- check for Explosion hit missiles
    for k,e in pairs(self.gExplosions) do
        for k,missile in pairs(self.gBMissles) do
            if e.gShape:testPoint(0,0,0,missile.gBody:getX(),missile.gBody:getY()) then
                local exp = EXPLOSION:new(world,missile.gBody:getX(),missile.gBody:getY() - 15)
                table.insert(self.gExplosions,exp)
                                
                missile.gBody:destroy()
                table.remove(self.gBMissles,k)
                self.mLevel.destMissiles = self.mLevel.destMissiles + 1
                self.Score = self.Score + 10
            end
        end
        --Explosion Update  
        if not e:update() then
            table.remove(self.gExplosions,k)
        end 
    end
    --For each missile destroy if off screen
    for k,m in pairs(self.gBMissles) do
        
        if m.gBody:getY() > 525 then
            m.gBody:destroy()
            table.remove(self.gBMissles,k)
            self.mLevel.destMissiles = self.mLevel.destMissiles + 1
        end
    end
    --Check Bomb Explode
    for k,b in pairs(self.gBombs) do
        b.DTTimer = b.DTTimer+dt
        if b.DTTimer > 1 then
            local e = EXPLOSION:new(world,b.gBody:getX(),b.gBody:getY())
            table.insert(self.gExplosions,e)
            
            b.gBody:destroy()
            table.remove(self.gBombs,k)
        end
    end
    
    --Cursor Movement
    if love.keyboard.isDown('up') and self.mCursor.yPos > 5 then
        self.mCursor.yPos = self.mCursor.yPos - 8
    elseif self.mCursor.yPos < 5 then
        self.mCursor.yPos = 5
    end
    
    if love.keyboard.isDown('right') and self.mCursor.xPos < 790 then
        self.mCursor.xPos = self.mCursor.xPos + 8
    elseif self.mCursor.xPos > 790 then
        self.mCursor.xPos = 790
    end
    
    if love.keyboard.isDown('down') and self.mCursor.yPos < (485 - self.mCursor.height) then
        self.mCursor.yPos = self.mCursor.yPos + 8
    elseif self.mCursor.yPos > 480 then
        self.mCursor.yPos = 480
    end
    
    if love.keyboard.isDown('left') and self.mCursor.xPos > 5 then
        self.mCursor.xPos = self.mCursor.xPos - 8
    elseif self.mCursor.xPos < 5 then
        self.mCursor.xPos = 5
    end    
    
end

function GAME:launchWave()    
    local num_missiles = math.random(1,self.mLevel.MSpawnedMissile)
    
    for i=1, num_missiles do
        self:launchMissile()
    end
end

function GAME:launchMissile()
    if self.mLevel.numMissiles > self.mLevel.misCount then
        local xSpawnPoints = {750,0,150,250,350,450,550,650,600,500,400,300,200,100,700,800}
        local index = math.random(1,15)
        local xSpawnPoints = xSpawnPoints[index]
        local ySpawnPoint = 35
        local m = MISSILE:new(world,xSpawnPoints,ySpawnPoint,self.mLevel.MSpeed,self.TDirection)

        table.insert(self.gBMissles,m)
        self.mLevel.misCount = self.mLevel.misCount + 1
    end
end

function GAME:buildCities()
    return {CITY:new(105,513),CITY:new(176,513),CITY:new(247,513),CITY:new(554,513),CITY:new(625,513),CITY:new(696,513)}
end

function GAME:buildTowers()
    return {TOWER:new(0,490),TOWER:new(390,485),TOWER:new(780,490)}
end

function GAME:drawForeground()
    love.graphics.setColor(self.mLevel.gColor)
    love.graphics.rectangle('fill',0 ,525,800,75)
    love.graphics.rectangle('fill',0,500,50,25)
    love.graphics.rectangle('fill',750,500,50,25)
    love.graphics.rectangle('fill',300,515,200,10)
    love.graphics.rectangle('fill',325,505,150,10)
    love.graphics.rectangle('fill',350,495,100,10)
end

function GAME:gDraw()
    love.graphics.setBackgroundColor(self.mLevel.bgColor)
    self:drawForeground()
    love.graphics.print("Score: "..self.Score ,400,10)
    for k,a in pairs(self.Tower) do
        a:draw()
    end    
    
    for k,b in pairs(self.gBombs) do
        b:draw()
    end
    
    for k,c in pairs(self.Cities) do
        c:draw(self.mLevel.cityColor)
    end    
    
    for k,m in pairs (self.gBMissles) do
        m:draw(self.mLevel.mistColor,self.mLevel.misColor)
    end
    
    --Explosion Render
    for k,e in pairs(self.gExplosions) do  
        e:draw()
    end
    
    self.mCursor:draw()
end

function GAME:shoot()
    if self.mCursor.xPos < 250 then
        if self.Tower[1].bombCount > 0 then
            local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[1].xPos,self.Tower[1].yPos)    
            table.insert(self.gBombs,b)
            self.Tower[1].bombCount = self.Tower[1].bombCount - 1
        elseif self.Tower[2].bombCount > 0 then
            local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[2].xPos,self.Tower[2].yPos)    
            table.insert(self.gBombs,b)
            self.Tower[2].bombCount = self.Tower[2].bombCount - 1
        elseif self.Tower[3].bombCount > 0 then
            local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[3].xPos,self.Tower[3].yPos)    
            table.insert(self.gBombs,b)
            self.Tower[3].bombCount = self.Tower[3].bombCount - 1
        end
    elseif self.mCursor.xPos < 550 and self.mCursor.xPos > 250 then
        if self.Tower[2].bombCount > 0 then
            local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[2].xPos,self.Tower[2].yPos)    
            table.insert(self.gBombs,b)
            self.Tower[2].bombCount = self.Tower[2].bombCount - 1
        else
            if self.mCursor.xPos <= 400 then
                if self.Tower[1].bombCount > 0 then
                    local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[1].xPos,self.Tower[1].yPos)    
                    table.insert(self.gBombs,b)
                    self.Tower[1].bombCount = self.Tower[1].bombCount - 1
                elseif self.Tower[3].bombCount > 0 then
                    local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[3].xPos,self.Tower[3].yPos)    
                    table.insert(self.gBombs,b)
                    self.Tower[3].bombCount = self.Tower[3].bombCount - 1
                end
            elseif self.mCursor.xPos >= 400 then
                if self.Tower[3].bombCount > 0 then
                    local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[3].xPos,self.Tower[3].yPos)    
                    table.insert(self.gBombs,b)
                    self.Tower[3].bombCount = self.Tower[3].bombCount - 1
                elseif self.Tower[1].bombCount > 0 then
                    local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[1].xPos,self.Tower[1].yPos)    
                    table.insert(self.gBombs,b)
                    self.Tower[1].bombCount = self.Tower[1].bombCount - 1
                end
            end
        end
    elseif self.mCursor.xPos > 550 then
        if self.Tower[3].bombCount > 0 then
            local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[3].xPos,self.Tower[3].yPos)    
            table.insert(self.gBombs,b)
            self.Tower[3].bombCount = self.Tower[3].bombCount - 1
        elseif self.Tower[2].bombCount > 0 then
            local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[2].xPos,self.Tower[2].yPos)    
            table.insert(self.gBombs,b)
            self.Tower[2].bombCount = self.Tower[2].bombCount - 1
        elseif self.Tower[1].bombCount > 0 then
            local b = BOMB:new(world,self.mCursor.xPos-10,self.mCursor.yPos-5,self.Tower[1].xPos,self.Tower[1].yPos)    
            table.insert(self.gBombs,b)
            self.Tower[1].bombCount = self.Tower[1].bombCount - 1
        end
    end
end

function GAME:NextLevel()
    self.gCLevel = self.gCLevel + 1
    self.Score = self.Score + table.getn(self.Cities)*50 + self.Tower[1].bombCount * 5 + self.Tower[2].bombCount * 5 + self.Tower[3].bombCount * 5
    self.mLevel = LEVEL:new(self.gCLevel)
    self.Tower[1].bombCount = 20
    self.Tower[2].bombCount = 20
    self.Tower[3].bombCount = 20
end

function GAME:GameOver()
    self.gCLevel = 1
    self.Score = 0
    self.mLevel = LEVEL:new(self.gCLevel)
    self.Tower[1].bombCount = 20
    self.Tower[2].bombCount = 20
    self.Tower[3].bombCount = 20
    self.Cities = self:buildCities()
    self.TDirection = {10,105,176,247,554,625,696,390,770}
end