EntityManager = Class 
{
  init = function (self)
    self.entity_id  = 0
    self.entities   = {}
    self.systems    = {}
    self.rootNode   = NodeEntity();
  end
}

function EntityManager:getByID(id)
  return self.entities[id]
end

function EntityManager:deleteEntity(entity)
  
  for _,system in pairs(self.systems) do
    if (system.entities[entity.id] ~= nil) then
      system:removeEntity(entity)
    end
  end
  
  local ent = self.entities[entity.id]

  if (ent ~= nil and ent.parent ~= nil) then
    for id, ch in pairs(ent.parent.children) do
      if (ch.id == entity.id) then 
        ent.parent.children[id] = nil 
        break
      end
    end
  end
  
  if (self.entities[entity.id] ~= nil) then
    self.entities[entity.id] = nil
  end  
  
end

function EntityManager:removeEntity(entity)
  entity.forDelete = true
end

function EntityManager:addEntity(entity, node)
  self.entity_id = self.entity_id + 1 
  entity.id = self.entity_id
  table.insert(self.entities, self.entity_id, entity)
  if (node ~= nil) then
    node:addChild(entity)
    entity.parent = node
  end
end

function EntityManager:addSystem(system, priority)
  self.systems[system.id] = system
end

function EntityManager:addToSystem(entity, system_name)
  local sys = self.systems[system_name] 
  assert(sys, 'System '..system_name..' not exist')
  sys:add(entity)
end

function EntityManager:update(dt)
  for key,ent in pairs(self.entities) do
    if ent.forDelete then
      --self.entities[key] = nil
      self:deleteEntity(ent)
    end
  end

  for _,system in pairs(self.systems) do
    system:update(dt)
  end
end

function EntityManager:draw(dt)
  for _,system in pairs(self.systems) do
    system:draw(dt)
  end
end
