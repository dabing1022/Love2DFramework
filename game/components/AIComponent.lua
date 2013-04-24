AIComponent = Class
{
  __includes = Component,
  init = function(self, target)
    Component.init(self, target)
    self.id      = "AIComponent"
    self.state   = 'follow'
    
    self.target  = target
  end
}

--function AIComponent:

