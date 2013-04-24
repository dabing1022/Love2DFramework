CollisionShape = Class
{
  init = function (self)
    
  end
}

function CollisionShape:checkCollision(shape)
  if (self['check'..shape.type] ~= nil) then
    return self['check'..shape.type](self, shape)
  end
end
