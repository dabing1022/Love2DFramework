BulletSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id         = 'BulletSystem'
    self.rootNode   = root
    
    game.events.register('PLAYER_SHOT', function(...) self:playerShot(...) end)
  end
}

function BulletSystem:playerShot(id)
  local player    = game.em:getByID(id)
  local move      = player:getComponent('MotionComponent')
  local position  = player:getComponent('PositionComponent')
  
  local dir = move.start_dir:rotated(position.rot_x) * (-1)
  local ofset     = dir:normalized() * 15
   
  BulletEntity(position.x + ofset.x, position.y + ofset.y, dir, dir * move.vel:len() * 1.5)
  
end

function BulletSystem:update(dt)
  for _, ent in pairs(self.entities) do
    local move = ent:getComponent('MotionComponent')
    local bull = ent:getComponent('BulletComponent')
    move:applyForce(bull.speed * bull.dir)
    bull.cur_timelife = bull.cur_timelife + dt
    
    if (bull.cur_timelife > bull.timelife) then
      game.em:removeEntity(ent)
    end
  end
end
