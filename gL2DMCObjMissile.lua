MISSILE = class ('MISSILE')

function MISSILE:initialize(world,x,y,speed,direction)

    self.xPos = x
    self.yPos = y
    self.width = 10
    self.height = 10
    
    self.gBody = love.physics.newBody(world,x,y,'kinematic')
    self.gBody:setBullet(true)
    self.gBody:setLinearVelocity(self:getInitial(speed,direction))
    self.gShape = love.physics.newRectangleShape(x,y,self.width,self.height)
    
    self.gFixture = love.physics.newFixture(self.gBody, self.gShape, 0.1)
end

function MISSILE:getInitial(speed,direction)    
    local rate = (15 - speed)
    local xDest = {95,105,110,120,690,169,240,554,625,696,683,550}
    
    vx = direction[math.random(1,table.getn(direction))] - self.xPos
    vy = 500 - self.yPos
    
    return vx/rate,vy/rate
end

function MISSILE:draw(tailColor,misColor)
    love.graphics.setColor(tailColor)
    love.graphics.line(self.xPos,self.yPos,
                       self.xPos + self.height,self.yPos,
                       self.gBody:getX() + 10,self.gBody:getY(),
                       self.gBody:getX(),self.gBody:getY(),
                       self.xPos,self.yPos)
   
    love.graphics.setColor(misColor)
    love.graphics.rectangle('fill',self.gBody:getX(),self.gBody:getY(),self.width,self.height)
end