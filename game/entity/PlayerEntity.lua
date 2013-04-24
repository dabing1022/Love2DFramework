PlayerEntity = 
function(x, y)
  local player = Entity()
  
  game.em:addEntity   (player, game.em.rootNode)  
  -----------------------------
  local pc = PositionComponent(x or 0, y or 0)
  player:addComponent(pc)
  -----------------------------
  local ac = AnimateComponent('assets/images/ship.png', 40, 40)
  ac:addAnimation('base',   'loop', 0.2, '1,1')  
  ac:addAnimation('base45', 'loop', 0.2, '2,1')  
  player:addComponent(ac)
  -----------------------------
  local mc = MotionComponent()  
  player:addComponent(mc)
  -----------------------------
  local ic = InputComponent()  
  player:addComponent(ic)  

  ic:addAction(InputSystem.KEY_PRESS, 'PLAYER_MOVE',   'w', 8)
  ic:addAction(InputSystem.KEY_PRESS, 'PLAYER_MOVE',   's', 2)  
  
  ic:addAction(InputSystem.KEY_PRESS, 'PLAYER_MOVE',   'a', 4)
  ic:addAction(InputSystem.KEY_PRESS, 'PLAYER_MOVE',   'd', 6)
    
  ic:addAction(InputSystem.KEY_UP   , 'PLAYER_SHOT',   ' ')
  -----------------------------
  player:addComponent(HealthComponent(5)) 
  -----------------------------
  local sc = ShipComponent(800, player)  
  player:addComponent(sc)    
  -----------------------------  
  player:addComponent(CollisionComponent(CircleShape(pc, 16), 'Player'))
  -----------------------------  
  game.em:addToSystem (player, 'RenderSystem')  
  game.em:addToSystem (player, 'InputSystem')  
  game.em:addToSystem (player, 'MoveSystem')  
  
  return player  
 end

