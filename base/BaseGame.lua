Vector2D = require "base/libs/hump/vector"

require "game/collision/CollisionShape"
require "game/collision/CircleShape"

require "base/Entity"
require "base/Component"
require "base/EntityManager"
require "base/System"

BaseGame = Class
{
  init = function(self, name)
       
    self.entitiesFolder    = "game/entity/"
    self.componentsFolder  = "game/components/"
    self.systemsFolder     = "game/systems/"
    
    self.events = require 'base/libs/hump/signal'
    
    self:loadFiles(self.entitiesFolder)
    self:loadFiles(self.componentsFolder)
    self:loadFiles(self.systemsFolder)

    self.em = EntityManager()
  end
}

function BaseGame:loadFiles(dir)
  local files = love.filesystem.enumerate(dir)
  for k, file in ipairs(files) do       
    local fileName, num = string.gsub(file, "(.*).lua", "%1")
    if (num) then require (dir..fileName) end
  end
end

function BaseGame:draw()
  self.em:draw()
end

function BaseGame:update(dt)
  self.em:update(dt)
end

