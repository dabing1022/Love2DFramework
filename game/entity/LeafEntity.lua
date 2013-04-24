LeafEntity = Class
{
  __includes = Entity,
  init = function(self, x, y, rot_x, rot_y, img)
    Entity.init(self)
    self.pos      = PositionComponent(x, y, rot_x, rot_y)
    if (img) then self.img      = RenderComponent(img)end

    self:addComponent(self.pos)
    if (img) then self:addComponent(self.img) end
  end
}


