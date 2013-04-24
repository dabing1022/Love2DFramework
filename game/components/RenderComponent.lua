RenderComponent = Class
{
  __includes = Component,
  init = function(self, img)
    Component.init(self)
    self.id = "RenderComponent"
    self.img = love.graphics.newImage(img)
    
    self.width  = self.img:getWidth()
    self.height = self.img:getHeight()
    
    self.isRender = true
  end
}
