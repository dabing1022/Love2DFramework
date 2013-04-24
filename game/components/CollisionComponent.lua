CollisionComponent = Class
{
  __includes = Component,
  init = function(self, shape, colGroup)
    Component.init(self)
    self.id       = "CollisionComponent"
    self.shape    = shape 
    self.colGroup = colGroup
  end
}



