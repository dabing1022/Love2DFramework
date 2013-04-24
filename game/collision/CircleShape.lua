CircleShape = Class
{
  __includes = CollisionShape,
  init = function(self, pos, radius)
    CollisionShape(self)
    self.type   = 'CircleShape'
    self.pos    = pos
    self.radius = radius
  end
}

function CircleShape:checkCircleShape(shape)
  if 
  (
    (shape.pos.x - self.pos.x) * (shape.pos.x - self.pos.x) +
    (shape.pos.y - self.pos.y) * (shape.pos.y - self.pos.y) < 
    (shape.radius + self.radius) * (shape.radius + self.radius)
  )  
  then
    --return true; 
    local b = Vector2D(shape.pos.x - self.pos.x, shape.pos.y - self.pos.y)
    b = b:normalized() * self.radius
    --a = self.pos.x
    res = {}
    res.point = {}
    return true
  else 
    return nil
  end
end
