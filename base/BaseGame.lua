Vector2D = require "base/libs/hump/vector"

require "game/collision/CollisionShape"
require "game/collision/CircleShape"

require "base/Entity"
require "base/Component"
require "base/EntityManager"
require "base/ComponentManager"
require "base/System"

local entitiesFolder    = "game/entity/"
local componentsFolder  = "game/components/"
local systemsFolder     = "game/systems/"

BaseGame = Class
{
  init = function(self, name)
       
    self:loadFiles(entitiesFolder)
    self:loadFiles(componentsFolder)
    self:loadFiles(systemsFolder)
    
    self.cm = ComponentManager()
    self.em = EntityManager()
  end
}

BaseGame.events = require 'base/libs/hump/signal'

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

