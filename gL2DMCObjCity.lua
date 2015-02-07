CITY = class('CITY')

function CITY:initialize(x,y)
    
    self.xPos = x
    self.yPos = y
    self.width = 35
    self.height = 25
    
    self.gBody = love.physics.newBody(world,x,y,'dynamic')
    self.gShape = love.physics.newRectangleShape(x,y,self.width,self.height)
    self.fixture = love.physics.newFixture(self.gBody,self.gShape,0.1)

end

function CITY:draw(color)
    love.graphics.setColor(color)
    love.graphics.polygon('fill',self.gShape:getPoints())
end