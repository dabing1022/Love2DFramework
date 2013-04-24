GemEntity = 
function (x, y, gtype, map)


  
  local gem = Entity()  
  game.em:addEntity   (gem, map)  
  
  local back = LeafEntity( 16, 16, 0, 0,'assets/images/map/active_back.png')
  back:getComponent('RenderComponent').isRender = false
  game.em:addEntity(back, gem)
  -----------------------------
  local pc = PositionComponent(x or 0, y or 0)
  gem:addComponent(pc)
  -----------------------------
  local img = 'assets/images/gems/blue_gem.png'
  if (gtype == 2) then img = 'assets/images/gems/green_gem.png'   end
  if (gtype == 3) then img = 'assets/images/gems/red_gem.png'     end
  if (gtype == 4) then img = 'assets/images/gems/yellow_gem.png'  end 
  if (gtype == 5) then img = 'assets/images/gems/exp.png'         end 
  if (gtype == 6) then img = 'assets/images/gems/money.png'       end 
  if (gtype == 7) then img = 'assets/images/gems/time.png'        end 
  if (gtype == 8) then img = 'assets/images/gems/bomb.png'        end 

  
  local gc = GemComponent(back, gtype)
  gem:addComponent(gc)


  local ac = AnimateComponent(img, 32, 32)
  ac:addAnimation('base',   'loop', 0.2, '1,1')  

  gem:addComponent(ac)
  -----------------------------
  local mc = MotionComponent()  
  gem:addComponent(mc)

  -----------------------------  
  game.em:addToSystem (gem, 'RenderSystem')  
  game.em:addToSystem (gem, 'MoveSystem')  

  return gem  
 end
