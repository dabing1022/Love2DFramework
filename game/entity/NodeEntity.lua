NodeEntity = Class
{
  __includes = Entity,
  init = function(self, x, y, rot_x, rot_y)
    Entity.init(self)
    self.pos      = PositionComponent(x, y, rot_x, rot_y)
    
    self:addComponent(PositionComponent(pos))
  end
}

