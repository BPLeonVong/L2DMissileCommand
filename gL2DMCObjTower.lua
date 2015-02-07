TOWER = class ('TOWER')

function TOWER:initialize(x,y)
    self.xPos = x
    self.yPos = y
    self.width = 20
    self.height = 10
    self.bombCount = 20
    
    self.gBody = love.physics.newBody(world,x,y,'dynamic')
    self.gShape = love.physics.newRectangleShape(x,y,self.width,self.height)
    self.fixture = love.physics.newFixture(self.gBody,self.gShape,0.1)
end

function TOWER:draw()
    love.graphics.setColor(math.random(0,255),math.random(0,255),math.random(0,255))
    love.graphics.rectangle('fill',self.xPos,self.yPos,self.width,self.height)    
    
    love.graphics.setColor(255,255,255)
    love.graphics.print(self.bombCount,self.xPos,self.yPos+20)
end