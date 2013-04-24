GuiSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id         = 'GuiSystem'      
    self.hearts    = {}    
    
    game.events.register('PLAYER_CHANGE_HEALTH', function(...) self:updateHealth(...) end)
    
  end
}

function GuiSystem:setPlayer(player)
  self.health     = player:getComponent('HealthComponent')
  self.player     = player
  
  for i = 1, self.health.max_health do
    self.hearts[i] = HeartEntity(50 + i*34, 50)
  end
  
end

function GuiSystem:updateHealth()
  for i = #self.hearts, 1, -1  do
    local cur = self.health.cur_health - (i - 1)
    local an = self.hearts[i]:getComponent('AnimateComponent')
    if (cur == 0.5) then      
      an:setAnimation('half')
    elseif (cur <= 0) then
      an:setAnimation('empty')
    else
      an:setAnimation('base')
    end
  end
end

function GuiSystem:add(entity, ...)
  self:setPlayer(entity)
end

function GuiSystem:update(dt)
  
end
