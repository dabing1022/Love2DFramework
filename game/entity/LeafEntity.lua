LeafEntity = Class
{
  __includes = Entity,
  init = function(self, x, y, rot_x, rot_y, img)
    Entity.init(self)
    self.pos      = PositionComponent(x, y, rot_x, rot_y)
    self.img      = RenderComponent(img)

    self:addComponent(self.pos)
    self:addComponent(self.img)   
  end
}


