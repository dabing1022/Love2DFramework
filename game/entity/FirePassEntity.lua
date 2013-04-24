FirePassEntity = 
function(x, y, parent)
  local fire = Entity()
  
  game.em:addEntity   (fire, parent)   
  -----------------------------
  local pc = PositionComponent(x or 0, y or 0)
  fire:addComponent(pc)
  -----------------------------
  local ac = AnimateComponent('assets/images/fire_pass.png', 40, 40) 
  ac:addAnimation('off', 'loop', 0.2, '3,1')  
  ac:addAnimation('on',  'loop', 0.4, '1-2,1') 
  fire:addComponent(ac)

  game.em:addToSystem (fire, 'RenderSystem')  
  
  return fire  
 end

