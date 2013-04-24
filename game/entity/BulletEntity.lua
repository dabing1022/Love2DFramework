BulletEntity = 
function(x, y, dir, start_vel)
  local bullet = Entity()
  
  game.em:addEntity   (bullet, game.em.rootNode)   
  local pc = PositionComponent(x, y)
  bullet:addComponent(pc)
  
  local ac = AnimateComponent('assets/images/bullet2.png', 16, 16)
  ac:addAnimation('base', 'loop', 0.1, '1-2,1')  
  bullet:addComponent(ac)
  
  dir = dir or Vector2D(0, 0)
  bullet:addComponent(MotionComponent(start_vel))
  bullet:addComponent(BulletComponent(dir, 1000))  
  bullet:addComponent(CollisionComponent(CircleShape(pc, 16), 'Bullet'))
    
  game.em:addToSystem (bullet, 'RenderSystem')  
  game.em:addToSystem (bullet, 'MoveSystem')  
  game.em:addToSystem (bullet, 'BulletSystem')  
  game.em:addToSystem (bullet, 'CollisionSystem')  
  
  return bullet  
 end

