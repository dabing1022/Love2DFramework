ScreenEffectSystem = Class
{
  __includes = System,
  init = function(self, root)
    System.init(self)
    self.id       = 'ScreenEffectSystem'   
    self.time     = 0.2
    self.time_cur  = 0
    self.on        = false
    self.root      = root
    self.trans     = 5
    --self.trans_max = 5
    
    game.events.register('PLAYER_DAMAGE', function(...) self:playerDamage(...) end)
  end
}

function ScreenEffectSystem:playerDamage()
  self.on = true
end
function ScreenEffectSystem:update(dt)
  
  if (self.on) then
    math.randomseed(os.time())
    self.trans = - self.trans
    local rotx = self.trans 
    local roty = -self.trans
    local pos = self.root:getComponent('PositionComponent')    
    pos.x = pos.x + rotx
    pos.y = pos.y + roty

    if (self.time_cur > self.time) then
      self.time_cur = 0
      self.on       = false
      pos.x = 0
      pos.y = 0
    end
    self.time_cur = self.time_cur + dt
  end
end
