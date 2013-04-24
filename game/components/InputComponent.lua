InputComponent = Class
{
  __includes = Component,
  init = function(self)
    Component.init(self)
    self.id     = "InputComponent"
    
    self.keymap = {}
  end
}

function InputComponent:addAction(action_type, action, key, ...)
  if (not  self.keymap[key]) then self.keymap[key] = {} end
  local map = {}
  map.action_type  = action_type
  map.action_name  = action
  map.id           = self.entity.id
  map.params       = {...}
  table.insert(self.keymap[key], map)
end

