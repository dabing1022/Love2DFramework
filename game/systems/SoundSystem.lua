SoundSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id         = 'SoundSystem'
    self.sounds     = {}
    
    game.events.register('PLAYER_SHOT',             function(...) self:playerShot(...) end)
    game.events.register('BULLET_ENEMY_COLLISION',  function(...) self:enemyShot(...) end)
    game.events.register('PLAYER_ENEMY_COLLISION',  function(...) self:enemyShot(...) end)
  end
}

function SoundSystem:enemyShot()
  self:play('explode')
end

function SoundSystem:playerShot()
  self:play('shot')
end

function SoundSystem:play(name)
  love.audio.stop(self.sounds[name])
  love.audio.play(self.sounds[name])
end

function SoundSystem:addSound(name, path)
  self.sounds[name] = love.audio.newSource(path, 'static')
end

function SoundSystem:update(dt)

end
