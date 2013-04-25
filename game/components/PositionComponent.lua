PositionComponent = Class
{
  __includes = Component,
  init = function(self, x, y, rot_x, rot_y, scale_x, scale_y)
    Component.init(self)
    self.id     = "PositionComponent"
    
    self.x      = x or 0
    self.y      = y or 0
    
    self.rot_x  = rot_x or 0
    self.rot_y  = rot_y or 0   
    
    self.scale_x  = scale_x or 1   
    self.scale_y  = scale_y or 1   
    
    self.rot_dump = 0
  end
}

function PositionComponent:setPosition(x, y)
  self.x = x
  self.y = y
end

