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
  local name = string.gsub (comp.id, 'Component', '')
  if not(self['getC'..(name)]) then    
    self['getC'..name] = comp
  else
    assert(true, 'Method '..'getC'..(comp.id)..' already exist')
  end
  comp:addEntity(self)
end

function Entity:getComponent(comp_id)
  return self.components[comp_id]
end

function Entity:removeComponent(comp)
  if (self.components[comp.id] ~= nil) then
    self.components[comp.id] = nil
  end
  local name = string.gsub (comp.id, 'Component', '')
  if (self['getC'..(name)]) then 
    self['getC'..(name)] = nil
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