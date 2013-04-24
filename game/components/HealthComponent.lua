HealthComponent = Class
{
  __includes = Component,
  init = function(self, max_health, cur_health)
    self.id         = "HealthComponent"
    if (not (cur_health)) then
      self.max_health = max_health
      self.cur_health = max_health     
    else
      self.max_health = max_health
      self.cur_health = cur_health
    end
  end
}

function HealthComponent:doDamage(dmg)
  self.cur_health = self.cur_health - dmg
end
