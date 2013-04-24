MapEntity = 
function(x, y, map)
  local map = Entity()
  
  game.em:addEntity   (map, game.em.rootNode)  
  local pc = PositionComponent(x, y)
  map:addComponent(pc)
  
  local mc = MapComponent(x, y)
  map:addComponent(mc)
  
  local mass = require('maps/1')
  
  math.randomseed( os.time() )
  
  local size_x = 10
  local size_y = 10
     
  game.em:addEntity(LeafEntity(0, 0, 0, 0,'assets/images/map/ltop.png'), map)
  game.em:addEntity(LeafEntity(size_x * 32 + 32, 0, 0, 0,'assets/images/map/rtop.png'), map)
  game.em:addEntity(LeafEntity(0, size_y * 32 + 32, 0, 0,'assets/images/map/lbottom.png'), map)
  game.em:addEntity(LeafEntity(size_x * 32 + 32, size_y * 32 + 32, 0, 0,'assets/images/map/rbottom.png'), map)
  
  for i = 1, size_x do   
    game.em:addEntity(LeafEntity(0, i*32, 0, 0,'assets/images/map/lcenter.png'), map)
    game.em:addEntity(LeafEntity(size_x * 32 + 32, i*32, 0, 0,'assets/images/map/rcenter.png'), map)
    game.em:addEntity(LeafEntity(i*32, 0, 0, 0,'assets/images/map/tcenter.png'), map)
    game.em:addEntity(LeafEntity(i*32, size_y * 32 + 32, 0, 0,'assets/images/map/bcenter.png'), map)           
  end
  
  local gem = {}
  
  for i = 1, size_x do
    for j = 1, size_y do 
      game.em:addEntity(LeafEntity(i*32, j*32, 0, 0,'assets/images/map/cake.png'), map)
    end
  end
 
  
  for i = 1, size_x do
    mc.cells[i] = {}
    for j = 1, size_y do     
      gem = GemEntity(i*32,j*32, math.random(7), map)        
      mc.cells[i][j] = gem
    end
  end  
  ----------------------------------------------------
  local ic = InputComponent()  
  gem:addComponent(ic)  
    
  ic:addAction(InputSystem.KEY_UP   , 'CELL_SELECTED',   'lmouse')
  ----------------------------------------------------
  
  game.em:addToSystem (map, 'RenderSystem')  
  game.em:addToSystem (gem, 'InputSystem')  

  return map  
 end

