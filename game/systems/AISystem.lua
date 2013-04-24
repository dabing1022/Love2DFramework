AISystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id         = 'AISystem'   
  end
}

function AISystem:update(dt)
  for _, entity in pairs(self.entities) do
      local move      = entity:getComponent('MotionComponent')
      local pos       = entity:getComponent('PositionComponent')
      local ai        = entity:getComponent('AIComponent')
      
      local tpos      = ai.target:getComponent('PositionComponent')
      local tmove     = ai.target:getComponent('MotionComponent')
      
      local rot   = math.atan2(tpos.x - pos.x, tpos.y - pos.y)
      local vec   = Vector2D(tpos.x - pos.x, tpos.y - pos.y)
      
      rot = math.pi - (rot - (math.pi))
      vec = vec:normalized()
      
      game.events.emit('ENEMY_MOVE', entity.id, rot, vec) 
  end
end

