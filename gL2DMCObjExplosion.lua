EXPLOSION = class('EXPLOSION')

--Clean up file

function EXPLOSION:initialize(world,x,y)
    self.stage = 1
    self.xPos = x
    self.yPos = y
    
    self.gBody = love.physics.newBody(world,self.xPos,self.yPos,'dynamic')
    self.gShape = love.physics.newPolygonShape(self:plotExplosion(self.stage))

    self.fixture = love.physics.newFixture(self.gBody, self.gShape, 1.0)
end

function EXPLOSION:update()
    
    if self.stage == 75 then
        self.gBody:destroy()
        return false
    elseif self.stage < 75 then
        self.stage = self.stage + 1
        self.gShape = love.physics.newPolygonShape(self:plotExplosion(self.stage))
        return true
    end
    
end

function EXPLOSION:draw()  
    love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
    love.graphics.polygon('fill', self.gShape:getPoints())      
end

function EXPLOSION:plotExplosion(stage)
    x = 0
    y = 0
    if stage < 15 then
        padding = stage * 2
    elseif stage > 15 and stage < 50 then
        padding = 45
    elseif stage >= 50 then
        padding = 80 - stage
    end
    return self.xPos,
           self.yPos - padding, 
           self.xPos + padding, 
           self.yPos, 
           self.xPos, 
           self.yPos + padding, 
           self.xPos - padding, 
           self.yPos    
end