CURSOR = class ('CURSOR')

function CURSOR:initialize(x,y)
    self.xPos = x
    self.yPos = y
    self.width = 20
    self.height = 10
end

function CURSOR:draw()
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill',self.xPos - (self.width/2),self.yPos - (self.height/2),self.width,self.height)    
end