MineEntity = 
function(x, y)
  local mine = Entity()
  
  game.em:addEntity   (mine, game.em.rootNode)   
  local pc = PositionComponent(x, y)
  mine:addComponent(pc)
  
  local ac = AnimateComponent('assets/images/mine.png', 40, 40)
  ac:addAnimation('base', 'loop', 0.3, '1-2,1', '1,1', '3,1')  
  mine:addComponent(ac)  
  mine:addComponent(DamageComponent(0.5))  
  mine:addComponent(CollisionComponent(CircleShape(pc, 10), 'Mine'))
    
  game.em:addToSystem (mine, 'RenderSystem')  
  game.em:addToSystem (mine, 'CollisionSystem')  
  
  return mine  
 end

