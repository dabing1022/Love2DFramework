GameSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    
    self.id       = 'GameSystem'   
    
    self.points      = {}
    for i = 1, 8 do
      self.points[i] = 0
    end
    
    self.lock_points = {}
    for i = 1, 8 do
      self.lock_points[i] = 0
    end
        
    self.level       = 1
    self.cur_exp     = 0
    self.next_exp    = 10
    
    self.moves       = 5
    self.money       = 0
    
    game.events.register('GEM_DELETED',     function(...) self:gemDeleted(...) end)
    game.events.register('GEM_SWAP',        function(...) self:gemSwap(...) end)
    game.events.register('BLUE_GEM_CLICK',  function(...) self:blueGemClick(...) end)
    game.events.register('GREEN_GEM_CLICK', function(...) self:greenGemClick(...) end)
    game.events.register('YELLOW_GEM_CLICK',function(...) self:yellowGemClick(...) end)
    game.events.register('RED_GEM_CLICK',   function(...) self:redGemClick(...) end)
  end
}

function GameSystem:redGemClick(id, x, y)
  if (x > 144 and x < 162) then
    if (y > 224 and y < 256) then
      if (self.points[3] >= 10) then
        self.lock_points[3] = 1
        game.events.emit('GEM_COLOR_DELETE', 3)
        self.points[3] = self.points[3] - 10
      end
    end
  end 
end

function GameSystem:yellowGemClick(id, x, y)
  if (x > 144 and x < 162) then
    if (y > 264 and y < 296) then
      if (self.points[4] >= 10) then
        self.lock_points[4] = 1
        game.events.emit('GEM_COLOR_DELETE', 4)
        self.points[4] = self.points[4] - 10
      end
    end
  end 
end

function GameSystem:greenGemClick(id, x, y)
  if (x > 144 and x < 162) then
    if (y > 184 and y < 216) then
      if (self.points[2] >= 10) then
        self.lock_points[2] = 1
        game.events.emit('GEM_COLOR_DELETE', 2)
        self.points[2] = self.points[2] - 10
      end
    end
  end 
end

function GameSystem:blueGemClick(id, x, y)
  if (x > 144 and x < 162) then
    if (y > 154 and y < 172) then
      if (self.points[1] >= 10) then
        game.events.emit('GEM_COLOR_DELETE', 1)
        self.points[1] = self.points[1] - 10
      end
    end
  end
end

function GameSystem:gemSwap(points)
  self.moves  = self.moves  - 1
  if (self.moves < 0) then self.moves = 0 end
end

function GameSystem:gemDeleted(points)
  local tcount = 0
  local gold   = 0
  local time   = 0
  
  for ctype, count in pairs(points) do
    if (self.lock_points[ctype] ~= 1) then
      self.points[ctype] =  self.points[ctype] + count
      tcount = tcount + 1
      
      if (ctype ~= 6) then
        gold = gold + count * 10
      else
        gold = gold + count * 100
      end
      
      if (count >= 4) then
        --time = time + 1
        game.events.emit('NED_BOMBS', 1)
      end    
    else
      self.lock_points[ctype] = 0
    end  
  end
  
  --- ходы
  if (points[7]) then 
    self.moves = self.moves + 1
  end
  --- золото
  if (points[6]) then 
    
  end
  --- опыт
  if (points[5]) then 
    self.cur_exp = self.cur_exp + points[5]
  end
  
  self.money    = self.money + gold  
  self.cur_exp  = self.cur_exp + tcount
  self.moves    = self.moves + time
  
  if (self.cur_exp >= self.next_exp) then
    self.cur_exp  = self.cur_exp - self.next_exp
    self.next_exp = self.next_exp + 10    
    self.level    = self.level + 1
  end
    
    self.money = self.money + 100 
 -- end

end

function GameSystem:update(dt)
  
end
