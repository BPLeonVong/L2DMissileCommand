LEVEL = class('LEVEL')

function LEVEL:initialize(LEVEL)

    self.bgColor            = {}
    self.gColor             = {}
    self.cityColor          = {}
    self.misColor           = {}
    self.mistColor          = {}
    
    self.numBombs           = 0
    self.numMissiles        = 0
    self.misCount           = 0
    self.destMissiles       = 0
    self.destCities         = 0
    
    self.MSpeed             = 0
    self.MSpawnedMissile    = 0
    self.CLevel             = 0
    self.MInterval          = 0
    
    self:loadLevel(LEVEL)
end

function LEVEL:loadLevel(LEVEL)
    self.destMissiles = 0
    self.numBombs = 30
    self.destCities = 0
    
    if self.CLevel ~= LEVEL then
        self.CLevel = LEVEL
        self.numMissiles = 10 + (self.CLevel * 2) 
        
        if self.CLevel == 1 then
            self.bgColor            = {0,0,0}
            self.gColor             = {219,132,28}
            self.cityColor          = {35,133,208}
            self.misColor           = {255,255,255}
            self.mistColor          = {193,47,47}
            self.MSpawnedMissile = 2
            self.MInterval = 4
            self.MSpeed = 1
        elseif self.CLevel == 2 then
            self.bgColor            = {0,0,0}
            self.gColor             = {219,132,28}
            self.cityColor          = {35,133,208}
            self.misColor           = {255,255,255}
            self.mistColor          = {193,47,47}
            self.MSpawnedMissile = 2
            self.MInterval = 4
            self.MSpeed = 2
        elseif self.CLevel == 3 then
            self.bgColor            = {0,0,0}
            self.gColor             = {139,176,106}
            self.cityColor          = {35,133,208}
            self.misColor           = {255,255,255}
            self.mistColor          = {139,176,106}
            self.MSpawnedMissile = 3
            self.MInterval = 4
            self.MSpeed = 3
        elseif self.CLevel == 4 then
            self.bgColor            = {0,0,0}
            self.gColor             = {139,176,106}
            self.cityColor          = {35,133,208}
            self.misColor           = {255,255,255}
            self.mistColor          = {139,176,106}
            self.MSpawnedMissile = 3
            self.MInterval = 3
            self.MSpeed = 4
        elseif self.CLevel == 5 then
            self.bgColor            = {0,0,0}
            self.gColor             = {35,133,208}
            self.cityColor          = {139,176,106}
            self.misColor           = {255,255,255}
            self.mistColor          = {193,47,47}
            self.MSpawnedMissile = 3
            self.MInterval = 3
            self.MSpeed = 5
        elseif self.CLevel == 6 then
            self.bgColor            = {0,0,0}
            self.gColor             = {35,133,208}
            self.cityColor          = {139,176,106}
            self.misColor           = {255,255,255}
            self.mistColor          = {193,47,47}
            self.MSpawnedMissile = 4
            self.MInterval = 3
            self.MSpeed = 6
        elseif self.CLevel == 7 then
            self.bgColor            = {0,0,0}
            self.gColor             = {193,47,47}
            self.cityColor          = {35,133,208}
            self.misColor           = {255,255,255}
            self.mistColor          = {228,210,64}
            self.MSpawnedMissile = 4
            self.MInterval = 2
            self.MSpeed = 7
        elseif self.CLevel == 8 then
            self.bgColor            = {0,0,0}
            self.gColor             = {193,47,47}
            self.cityColor          = {35,133,208}
            self.misColor           = {255,255,255}
            self.mistColor          = {228,210,64}
            self.MSpawnedMissile = 4
            self.MInterval = 2
            self.MSpeed = 8
        elseif self.CLevel == 9 then
            self.bgColor            = {35,133,208}
            self.gColor             = {139,176,106}
            self.cityColor          = {219,132,28}
            self.misColor           = {0,0,0}
            self.mistColor          = {193,47,47}
            self.MSpawnedMissile = 5
            self.MInterval = 2
            self.MSpeed = 8
        elseif self.CLevel == 10 then
            self.bgColor            = {35,133,208}
            self.gColor             = {139,176,106}
            self.cityColor          = {219,132,28}
            self.misColor           = {0,0,0}
            self.mistColor          = {193,47,47}
            self.MSpawnedMissile = 5
            self.MInterval = 2
            self.MSpeed = 8
        elseif self.CLevel == 11 then
            self.bgColor            = {33,133,55}
            self.gColor             = {0,0,0}
            self.cityColor          = {35,133,208}
            self.misColor           = {0,0,0}
            self.mistColor          = {255,255,255}
            self.MSpawnedMissile = 5
            self.MInterval = 2
            self.MSpeed = 8
        elseif self.CLevel == 12 then
            self.bgColor            = {33,133,55}
            self.gColor             = {0,0,0}
            self.cityColor          = {35,133,208}
            self.misColor           = {0,0,0}
            self.mistColor          = {255,255,255}
            self.MSpawnedMissile = 6
            self.MInterval = 2
            self.MSpeed = 8
        elseif self.CLevel >= 13 then
            self.bgColor            = {33,133,55}
            self.gColor             = {0,0,0}
            self.cityColor          = {35,133,208}
            self.misColor           = {0,0,0}
            self.mistColor          = {255,255,255}
            self.MSpawnedMissile = 7
            self.MInterval = 2
            self.MSpeed = 8
        end
        
    end
end