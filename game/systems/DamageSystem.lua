DamageSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id         = 'DamageSystem'
    self.rootNode   = root
    
    game.events.register('PLAYER_DAMAGE', function(...) self:playerDamage(...) end)
  end
}

function DamageSystem:playerDamage(player, damager)
  local dmg = damager:getComponent('DamageComponent')
  if (dmg) then
    local health = player:getComponent('HealthComponent')
    health:doDamage(dmg.damage)
    game.events.emit('PLAYER_CHANGE_HEALTH') 
  end
end

function DamageSystem:update(dt)

end
