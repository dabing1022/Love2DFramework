ShipComponent = Class
{
  __includes = Component,
  init = function(self, engine_force, parent)
    Component.init(self)
    self.id     = "ShipComponent"
    
    self.engine_force = engine_force or 1000    
    if (parent) then
      self.fire_pass    =  FirePassEntity(20, 28, parent)
    end
  end
}

function ShipComponent:activeFirePass()
  local anim = self.fire_pass:getComponent('AnimateComponent')
  anim:setAnimation('on')
end

function ShipComponent:deactiveFirePass()
  local anim = self.fire_pass:getComponent('AnimateComponent')
  anim:setAnimation('off')
end

