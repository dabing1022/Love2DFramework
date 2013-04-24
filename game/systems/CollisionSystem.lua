CollisionSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id                = 'CollisionSystem'   
    self.collisionGroup    = {}
    self.collisionGroupEnt = {}
    
    game.events.register('BULLET_ENEMY_COLLISION', function(...) self:enemyShot(...) end)
    game.events.register('PLAYER_ENEMY_COLLISION', function(...) self:enemyCollision(...) end)
  end
}

function CollisionSystem:removeEntity(entity)
  self.entities[entity.id] = nil
  for key, group in pairs(self.collisionGroupEnt) do
    for key2, ent in pairs(self.collisionGroupEnt[key]) do
      if (ent.id == entity.id) then
        self.collisionGroupEnt[key][key2] = nil
      end
    end
  end
end

function CollisionSystem:enemyCollision(enemy, player)
  --game.em:removeEntity(enemy)
  game.em:removeEntity(player)
  local pos = player:getComponent('PositionComponent')
  local exp = ExplodeEntity(pos.x, pos.y) 
  game.events.emit('PLAYER_DAMAGE', enemy, player)   
  
end

function CollisionSystem:enemyShot(enemy, bullet)
  game.em:removeEntity(enemy)
  game.em:removeEntity(bullet)
  local pos = enemy:getComponent('PositionComponent')
  local exp = ExplodeEntity(pos.x, pos.y)
end

function CollisionSystem:afterAdd(entity, group)
  local col = entity:getComponent('CollisionComponent')
  table.insert(self.collisionGroupEnt[col.colGroup], entity)
end

function CollisionSystem:addCollisionMap(group1, group2, mess)
  local gmess = {group = group2, message = mess}
  table.insert(self.collisionGroup[group1], gmess)
end

function CollisionSystem:addCollisionGroup(name)
  self.collisionGroup[name]     = {}
  self.collisionGroupEnt[name]  = {}
end

function CollisionSystem:update(dt)
  for group, _ in pairs(self.collisionGroup) do
    for _, group1 in pairs(self.collisionGroup[group]) do
    
      if (group1.group ~= nil) then 

        for _, entA in pairs(self.collisionGroupEnt[group1.group]) do
          for _, entB in pairs(self.collisionGroupEnt[group]) do
            if (entA.id ~= entB.id) then        
              
              local colA    = entA:getComponent('CollisionComponent')
              local colB    = entB:getComponent('CollisionComponent')
              local col_res = colA.shape:checkCollision(colB.shape)
              
              if (col_res) then 
                game.events.emit(group1.message, entA, entB, col_res) 
              end
            
            end
          end
        end
      end
    
    end
    
  end
  
end

