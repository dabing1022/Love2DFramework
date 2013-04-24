MapSystem = Class
{
  __includes = System,
  init = function(self, map)
    System.init(self)
    self.id         = 'MapSystem'   
    self.map        = map
    self.for_delete = {}
    
    self.isUpdate   = false
    self.isDelete   = false
    
    self.lastUpdate = 0
    self.nextUpdate = 0.4
    
    self.bombCount  = 0
    
    local m = map:getComponent('MapComponent')
    
    for i = 1,  #m.cells do
      self.for_delete [i] = {}
      for j = 1,  #m.cells[i] do
        self.for_delete [i][j] = 0
      end
    end
    
    self.sell       = nil

    game.events.register('CELL_SELECTED',    function(...) self:cellSelected(...) end)
    game.events.register('CELL_SWAPED',      function(...) self:cellSwaped(...)   end)
    game.events.register('GEM_COLOR_DELETE', function(...) self:deleteColor(...)  end)
    game.events.register('NED_BOMBS',        function(...) self:needBombs(...)  end)
  end
}

function MapSystem:needBombs(count)
  self.bombCount = self.bombCount + count
end
  
function MapSystem:markForDelete(marks)  
  local map = self.map:getComponent('MapComponent')  
  for i,_ in pairs(marks) do    
      local x = marks[i].x
      local y = marks[i].y

      if (map.cells[x] and map.cells[x][y]) then
        if ((map.cells[x][y]):getComponent('GemComponent').ctype == 8) then
          
          for i = -1, 1 do
           for j = -1, 1 do
            if (map.cells[x + i] and map.cells[x +i][y + j]) then
              self.for_delete[x + i][y + j] = 1
            end
           end
          end          
         
        else
          self.for_delete[x][y] = 1
        end
      end
  end
end


function MapSystem:pattern1(x, y)
  local map = self.map:getComponent('MapComponent')
  local flag = false
  
  if not (map.cells[x] and map.cells[x][y]) then return false end
  if ((map.cells[x][y]):getComponent('MotionComponent').isMove) then return false end
    
  local cur = (map.cells[x][y]):getComponent('GemComponent').ctype
    
  if (map.cells[x - 2] and map.cells[x - 2][y] and not (map.cells[x - 2][y]):getComponent('MotionComponent').isMove) then
    local cell1 = (map.cells[x - 2][y]):getComponent('GemComponent').ctype
    if (cur == 8) and (cell1 ~= 8) then cur = cell1 end
    if (cur == cell1 or cell1 == 8) then
      if (map.cells[x - 1] and map.cells[x - 1][y] and not (map.cells[x - 1][y]):getComponent('MotionComponent').isMove) then
        local cell2 = (map.cells[x - 1][y]):getComponent('GemComponent').ctype
        if (cur == 8) and (cell2 ~= 8) then cur = cell2 end
        if (cur == cell2 or cell2 == 8) then
          flag = true
          self:markForDelete(
            {
              {x = x - 2, y = y},
              {x = x - 1, y = y},
              {x = x,     y = y},
            })
        end
      end
    end
  end
    
  return flag
end

function MapSystem:pattern2(x, y)
  local map = self.map:getComponent('MapComponent')
  local flag = false
  
  if not (map.cells[x] and map.cells[x][y]) then return false end
  if ((map.cells[x][y]):getComponent('MotionComponent').isMove) then return false end
  local cur = (map.cells[x][y]):getComponent('GemComponent').ctype
  
  
  if (map.cells[x][y - 2] and not (map.cells[x][y - 2]):getComponent('MotionComponent').isMove) then
    local cell1 = (map.cells[x][y - 2]):getComponent('GemComponent').ctype
    if (cur == 8) and (cell1 ~= 8) then cur = cell1 end
    if (cur == cell1 or cell1 == 8) then
      if (map.cells[x][y - 1] and not (map.cells[x][y - 1]):getComponent('MotionComponent').isMove) then
        local cell2 = (map.cells[x][y - 1]):getComponent('GemComponent').ctype
        if (cur == 8) and (cell2 ~= 8) then cur = cell2 end
        if (cur == cell2 or cell2 == 8) then
          flag = true
          self:markForDelete(
            {
              {x = x, y = y - 2},
              {x = x, y = y - 1},
              {x = x, y = y},
            })
        end
      end
    end
  end  
  
  return flag
end

function MapSystem:deleteColor(color)
    
  local map = self.map:getComponent('MapComponent')
  local flag = false
  
  for i = 1,  #map.cells do
    for j = 1,  #map.cells[i] do  
      self.for_delete[i][j] = 0
    end
  end
  
  for i = 1,  #map.cells do
    for j = 1,  #map.cells[i] do      
      if (map.cells[i] and map.cells[i][j]) then
        if ((map.cells[i][j]):getComponent('GemComponent').ctype == color) then
          self.for_delete[i][j] = 1
          (map.cells[i][j]):getComponent('GemComponent'):setActive(true)
        end      
      end
    end
  end
  
  self.isUpdate = true
end

function MapSystem:checkForDelete()
  local map = self.map:getComponent('MapComponent')
  local flag = false
  
  for i = 1,  #map.cells do
    for j = 1,  #map.cells[i] do  
      self.for_delete[i][j] = 0
    end
  end
  
  for i = 1,  #map.cells do
    for j = 1,  #map.cells[i] do      
      if (self:pattern1(i, j) or self:pattern2(i, j)) then
        flag = true
      end
    end
  end
  
  return flag
end

function MapSystem:moveLines()
  local map = self.map:getComponent('MapComponent')
  for i = 1, #map.cells do
    for j = 1, #map.cells[i] - 1 do

      if (map.cells[i][j]) and not (map.cells[i][j + 1]) then        
        local cell_top = map.cells[i][j]
        local cell     = map.cells[i][j + 1]       
        
        if (not cell and cell_top) then
          local isMove  = cell_top:getComponent('MotionComponent').isMove
          if not (isMove) then
            cell_top:getComponent('MotionComponent'):setMove(i * 32, (j + 1) * 32)
            map.cells[i][j], map.cells[i][j + 1] = false, map.cells[i][j]           
          end
        end
      end
      
    end
  end
  
  for i = 1, #map.cells do
    if not(map.cells[i][1]) then
      local gem = math.random(7)
      if (self.bombCount > 0) then
        gem = 8
        self.bombCount = self.bombCount - 1
      end
      local gem = GemEntity(i*32, 0, gem, self.map)
      map.cells[i][1] = gem
      gem:getComponent('MotionComponent'):setMove(i * 32,  32)
    end
  end
end

function MapSystem:checkLines()
  local map = self.map:getComponent('MapComponent')
  self:checkForDelete()
  
  for x, mas in ipairs(self.for_delete) do
    for y, _ in ipairs(mas) do
      if (self.for_delete[x][y] == 1) then
        if (map.cells[x] and map.cells[x][y]) then 
          if not((map.cells[x][y]):getComponent('MotionComponent').isMove) then
            (map.cells[x][y]):getComponent('GemComponent'):setActive(true)          
            self.isUpdate = true
          end
        end
      else
        if (map.cells[x] and map.cells[x][y]) then 
          (map.cells[x][y]):getComponent('GemComponent'):setActive(false)
        end
      end
    end
  end
end

function MapSystem:checkSwap(x1, y1, x2, y2)
  local map = self.map:getComponent('MapComponent')
  map.cells[x1][y1], map.cells[x2][y2] = map.cells[x2][y2], map.cells[x1][y1]
  local flag = self:checkForDelete()
  map.cells[x1][y1], map.cells[x2][y2] = map.cells[x2][y2], map.cells[x1][y1]
  

  local dx = math.abs(x1 - x2)
  local dy = math.abs(y1 - y2)
  return (flag and ((dx == 1 and dy == 0) or (dx == 0 and dy == 1)))
end

function MapSystem:swapGems(x1, y1, x2, y2)
  local map = self.map:getComponent('MapComponent')
  

  if (map.cells[x1] and map.cells[x1][y1]) then
    local cell1 = map.cells[x1][y1]
    
    if (map.cells[x2] and map.cells[x2][y2]) then
      local cell2 = map.cells[x2][y2]
      
      cell1:getComponent('MotionComponent'):setMove(x2 * 32, y2 * 32)
      cell2:getComponent('MotionComponent'):setMove(x1 * 32, y1 * 32)     
      
      map.cells[x1][y1], map.cells[x2][y2] = map.cells[x2][y2], map.cells[x1][y1]
      
      game.events.emit('GEM_SWAP')
    end
  end 
end

function MapSystem:cellSwaped(id)    
  self.isDelete = true
end

function MapSystem:bombDetonate(x, y, radius)
  
  local map = self.map:getComponent('MapComponent')
  
  for i = 1,  #map.cells do
    for j = 1,  #map.cells[i] do  
      self.for_delete[i][j] = 0
    end
  end
  
  for i = 1,  #map.cells do
    for j = 1,  #map.cells[i] do      
      if (map.cells[i] and map.cells[i][j]) then

        if ((x - radius <= i) and (x + radius >= i))  then
          if ((y - radius <= j) and (y + radius >= j))  then
            
              self.for_delete[i][j] = 1
              (map.cells[i][j]):getComponent('GemComponent'):setActive(true)
              
          end
        end
      end
    end
  end
  
  self.isUpdate = true
end
     
function MapSystem:cellSelected(id, x, y, dir) 
  
  local  pos = self.map:getComponent('PositionComponent')  
  local xmap,_ = math.modf(((x - pos.x - 16) / 32) + 1)
  local ymap,_ = math.modf(((y - pos.y - 16) / 32) + 1)  
  local map = self.map:getComponent('MapComponent')
  
  --self:bombDetonate(xmap, ymap, 1)
  
  if (map.cells[xmap] and map.cells[xmap][ymap]) then    
    if (self.sell and (not (self.sell.x==xmap and self.sell.y==ymap)) ) then
      local cell = map.cells[self.sell.x][self.sell.y]:getComponent('GemComponent')
      cell:setActive(false) 
      if (self:checkSwap(xmap, ymap, self.sell.x, self.sell.y)) then
        self:swapGems(xmap, ymap, self.sell.x, self.sell.y)        
        self.sell = nil
      else
        local cell = map.cells[xmap][ymap]
        cell = cell:getComponent('GemComponent')
        cell:setActive(true)
        self.sell = {x = xmap, y = ymap}
      end   
    else     
      local cell = map.cells[xmap][ymap]
      cell = cell:getComponent('GemComponent')
      cell:setActive(true)
      self.sell = {x = xmap, y = ymap}
    end    
  end
end

function MapSystem:deleteGems()
  local map     = self.map:getComponent('MapComponent')
  local points  = {}
  
  for x, mas in ipairs(self.for_delete) do
    for y, _ in ipairs(mas) do
      if (self.for_delete[x][y] == 1) then
        if (map.cells[x] and map.cells[x][y]) then 
          local ctype = (map.cells[x][y]):getComponent('GemComponent').ctype
          
          if (points[ctype]) then 
            points[ctype] = points[ctype] + 1 
          else  
            points[ctype] = 1
          end
          
          game.em:removeEntity(map.cells[x][y])
          map.cells[x][y] = false
        end
      end
    end
  end
  
  game.events.emit('GEM_DELETED', points)
end

function MapSystem:update(dt)
  self:moveLines()
    
  if (self.isUpdate) then
    if (self.lastUpdate > self.nextUpdate) then
      self.isUpdate   = false
      self.lastUpdate = 0
      self:deleteGems()
    else
      self.lastUpdate = self.lastUpdate + dt
    end
  end
  
  if (self.isDelete) then
    self:checkLines()
    self.isDelete = false
  end
end

