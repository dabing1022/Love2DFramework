MotionComponent = Class
{
  __includes = Component,
  init = function(self)
    Component.init(self)
    self.id         = "MotionComponent"   
    
    self.isMove     = false
    self.movePoint  = {}
  end
}

function MotionComponent:setMove(x, y)
  self.movePoint.x = x
  self.movePoint.y = y
  
  self.isMove      = true
end

function MotionComponent:setStop()
  
  self.isMove     = false
  self.movePoint  = {}
  
end

