MoveSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id         = 'MoveSystem'   
    self.friction   = 0.98
    game.events.register('GEM_MOVE',   function(...) self:gemMove(...) end)
  end
}

function MoveSystem:gemMove(id, dir)  
  local ent   = self.entities[id]
  local move  = ent:getComponent('MotionComponent')  
end

function MoveSystem:update(dt)
  for _, entity in pairs(self.entities) do
    move  = entity:getComponent('MotionComponent')  
    pos   = entity:getComponent('PositionComponent')  
    if (move.isMove) then
      
      local vec = Vector2D(move.movePoint.x - pos.x, move.movePoint.y - pos.y)      
      if (vec:len2() > (4)) then
        
        vec = vec:normalized() * dt * 200
        pos.x = pos.x + vec.x
        pos.y = pos.y + vec.y
      else
        pos.x = move.movePoint.x
        pos.y = move.movePoint.y
        move:setStop()
        
        game.events.emit('CELL_SWAPED', entity.id)
      end
    end
  end
end

