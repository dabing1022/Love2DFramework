GemComponent = Class
{
  __includes = Component,
  init = function(self, back, ctype)
    self.id     = "GemComponent"
        
    self.back     = back
    self.isActive = false
    self.ctype    = ctype
        
  end
}
GemComponent.activeCell   = love.graphics.newImage('assets/images/map/active_back.png')
GemComponent.deactiveCell = love.graphics.newImage('assets/images/map/cake.png')

function GemComponent:setActive(isActive)
  self.isActive = isActive
  if (isActive) then
    self.back:getComponent('RenderComponent').isRender = true
  else
    self.back:getComponent('RenderComponent').isRender = false
  end
end

