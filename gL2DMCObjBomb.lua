BOMB = class('BOMB')

--clean up file

function BOMB:initialize(world,x,y,towerX, towerY)

    self.DTTimer = 0
    self.xTarget = x
    self.yTarget = y
    self.xTower = towerX
    self.yTower = towerY
    
    self.gBody = love.physics.newBody(world,self.xTower+5,self.yTower+2.5,"kinematic")
 
    local vx = self.xTarget - towerX
    local vy = self.yTarget - towerY
    
    self.gBody:setBullet(true)
    self.gBody:setLinearVelocity(vx,vy)
    self.gShape = love.physics.newRectangleShape(self.xTower+10,self.yTower+5,8,4)
    local x1,y1, x2, y2 = self.gShape:computeAABB(0,0,0)
    self.width = x2 - x1
    self.height = y2 - y1
    
    self.fixture = love.physics.newFixture(self.gBody,self.gShape,1.0)
end

function BOMB:draw()
    love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
    love.graphics.rectangle('fill',self.gBody:getX(),self.gBody:getY(),self.width,self.height)
end