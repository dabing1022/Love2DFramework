HeartEntity = 
function(x, y, state)
  local bullet = Entity()
  
  game.em:addEntity   (bullet, game.em.rootNode)   
  local pc = PositionComponent(x, y)
  bullet:addComponent(pc)
  
  local ac = AnimateComponent('assets/images/heart.png', 32, 32)
  ac:addAnimation('base', 'loop', 0.2, '1-2,1')  
  ac:addAnimation('half', 'loop', 0.2, '1-2,2')  
  ac:addAnimation('empty','loop', 0.2, '1,3')  
  if (state) then ac:setAnimation(state) end
  bullet:addComponent(ac)
  
    
  game.em:addToSystem (bullet, 'RenderSystem')  
  
  return bullet  
 end

