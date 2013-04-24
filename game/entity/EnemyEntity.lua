EnemyEntity = 
function(x, y, target)
  local bullet = Entity()
  
  game.em:addEntity   (bullet, game.em.rootNode)  
  local pc = PositionComponent(x, y)
  bullet:addComponent(pc)
  
  local ac = AnimateComponent('assets/images/nlo.png', 40, 40)
  ac:addAnimation('base', 'loop', 0.1, '1,1')  
  bullet:addComponent(ac)
    
  bullet:addComponent(MotionComponent())
  bullet:addComponent(DamageComponent(1))
  bullet:addComponent(AIComponent(target))
  bullet:addComponent(ShipComponent(200))
  bullet:addComponent(CollisionComponent(CircleShape(pc, 16), 'EnemyShip'))
    
  game.em:addToSystem (bullet, 'RenderSystem')  
  game.em:addToSystem (bullet, 'MoveSystem')  
  game.em:addToSystem (bullet, 'AISystem')  
  game.em:addToSystem (bullet, 'CollisionSystem')  
  
  return bullet  
 end

