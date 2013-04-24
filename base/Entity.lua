Entity = Class{
  init = 
    function(self, id)
      self.id           = id
      self.components   = {}
      self.children     = {}
      self.isManualDraw = false
      self.forDelete    = false
      self.parent       = nil
    end
}

function Entity:addComponent(comp)
  self.components[comp.id] = comp
  comp:addEntity(self)
end

function Entity:getComponent(comp_id)
  return self.components[comp_id]
end

function Entity:removeComponent(comp)
  if (self.components[id.comp] ~= nil) then
    self.components[id.comp] = nil
  end
end

function Entity:addChild(child)
  table.insert(self.children, child)
end


function Entity:update(dt)
  for _,comp in pairs(self.components) do
    comp:update(dt)
  end
end