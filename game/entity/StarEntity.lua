StarEntity = 
function(x, y, sc_x, parent)
  local bullet = Entity()
  
  game.em:addEntity   (bullet, parent or game.em.rootNode)   
  local pc = PositionComponent(x, y, 0, 0, sc_x, sc_y or sc_x)
  bullet:addComponent(pc)
  
  local ac = AnimateComponent('assets/images/start.png', 11, 11)
  ac:addAnimation('base', 'loop', 0.2, '1,1')  
  if (state) then ac:setAnimation(state) end
  bullet:addComponent(ac)
  
    
  game.em:addToSystem (bullet, 'RenderSystem')  
  
  return bullet  
 end

