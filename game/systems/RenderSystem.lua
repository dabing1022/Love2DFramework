RenderSystem = Class
{
  __includes = System,
  init = function(self, root)
    System.init(self)
    self.id         = 'RenderSystem'
    self.rootNode   = root
  end
}

function RenderSystem:update(dt)
  for _,entity in pairs(self.entities) do
    local anim  = entity:getComponent('AnimateComponent')
    if (anim ~= nil) then 
      if (anim.animation ~= nil) then
        anim.animation:update(dt)
      end
    end
  end
end

function RenderSystem:drawNode(node)
  for _,entity in pairs(node.children) do
    
    local pos   = entity:getComponent('PositionComponent')
    local ren   = entity:getComponent('RenderComponent')
    local anim  = entity:getComponent('AnimateComponent')
    local isDraw = true
    
    if (ren and not ren.isRender) then isDraw = false end

    if (pos ~= nil and isDraw) then
      love.graphics.push()      
         
        love.graphics.translate (pos.x, pos.y)    
        love.graphics.rotate    (pos.rot_x + pos.rot_dump, pos.rot_y)  
        love.graphics.scale     (pos.scale_x , pos.scale_y)  
        
        
        
          if     (entity.isManualDraw) then 
            entity:draw()
          elseif (anim ~= nil) then 
            love.graphics.translate (-anim.width / 2, -anim.height / 2) 
            anim.animation:draw(anim.img,0,0)            
          elseif (ren  ~= nil) then 
            love.graphics.translate (-ren.width / 2, -ren.height / 2) 
            love.graphics.draw(ren.img) 
          end
            
          self:drawNode(entity)
          
      love.graphics.pop()
    
    end    
  end
end

function RenderSystem:draw()
  local pos = self.rootNode:getComponent('PositionComponent')
  love.graphics.push()  
    love.graphics.translate (pos.x, pos.y)    
    love.graphics.rotate    (pos.rot_x + pos.rot_dump, pos.rot_y)  
    self:drawNode(self.rootNode)
  love.graphics.pop()
end
