System = Class
{
  init = function(self)
    self.entities = {}
  end
}

function System:update(dt)
  
end

function System:removeEntity(entity)
  self.entities[entity.id] = nil
end

function System:draw()
  
end

function System:afterAdd(entity)
  
end

function System:add(entity, ...)
  table.insert(self.entities, entity.id, entity)
  self:afterAdd(entity, ...)
end
