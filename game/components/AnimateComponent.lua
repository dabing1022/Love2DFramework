AnimateComponent = Class
{
  __includes = Component,
  init = function(self, img, sx, sy, mx, my)
    Component.init(self)
    self.id         = "AnimateComponent"
    self.animations = {}
    self.animation  = nil
    self.img        = love.graphics.newImage(img)
    
    self.width    = sx or 0
    self.height   = sy or 0
    
    local full_width  = mx or self.img:getWidth()
    local full_height = mx or self.img:getHeight()
    self.grid         = anim8.newGrid(sx, sy, full_width, full_height)
        
  end
}

function AnimateComponent:setAnimation(name)
  assert(self.animations[name], 'Animation not exist')
  if self.animation == self.animations[name] then
    return
  end
  if self.animation then
     self.animation:gotoFrame(1)
  end
  self.animation = self.animations[name] 
end

function AnimateComponent:addAnimation(name, atype, delay, ...)
  local animation = anim8.newAnimation(atype, self.grid(...), delay)
  self.animations[name] = animation
  if (self.animation == nil) then
    self.animation = animation
  end
end
