ExplodeEntity = 
function(x, y)
  local mine = Entity()
  
  game.em:addEntity   (mine, game.em.rootNode)   
  local pc = PositionComponent(x, y)
  mine:addComponent(pc)
  
  local ac = AnimateComponent('assets/images/explode.png', 40, 40)
  ac:addAnimation('base', 'once', 0.1, '1-5,1')  
  mine:addComponent(ac)
      
  game.em:addToSystem (mine, 'RenderSystem')  
  
  return mine  
 end

