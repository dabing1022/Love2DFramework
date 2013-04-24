Class = require "base/libs/hump/class"
require "base/BaseGame"
anim8 = require "base/libs/anim8"


function love.load()  

  love.graphics.setDefaultImageFilter('nearest', 'nearest')
  love.keyboard.setKeyRepeat(0.01, 0.2)  
  love.graphics.setBackgroundColor(100, 100, 100)
  
  game = BaseGame()  
  rs = RenderSystem(game.em.rootNode)
  game.em:addSystem(rs) 
  
end


function love.update(dt)
  game:update(dt) 
end

function love.draw() 
 game:draw()
end
