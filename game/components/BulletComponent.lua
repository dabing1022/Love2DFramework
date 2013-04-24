BulletComponent = Class
{
  __includes = Component,
  init = function(self, dir, speed, timelife)
    Component.init(self)
    self.id           = "BulletComponent"
    self.dir          = dir or Vector2D(1, 0) 
    self.speed        = speed
    self.timelife     = timelife or 1
    self.cur_timelife = 0
  end
}



