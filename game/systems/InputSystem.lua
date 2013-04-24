InputSystem = Class
{
  __includes = System,
  init = function(self)
    System.init(self)
    self.id         = 'InputSystem'
    self.input      = {}
        
    self.pressed    = {}
  end
}

InputSystem.KEY_PRESS = 1
InputSystem.KEY_DOWN  = 2
InputSystem.KEY_UP    = 3

InputSystem.mkey = {}
InputSystem.mkey['lmouse'] = 'l'
InputSystem.mkey['rmouse'] = 'r'

function InputSystem:afterAdd(entity)
  local input  = entity:getComponent('InputComponent')
  assert(input, 'Entity has no InputComponent')
  
  for key, action in pairs(input.keymap) do
    if (self.input[key] == nil) then self.input[key] = {} end
    for _, keym in pairs(input.keymap[key]) do 
      table.insert(self.input[key], keym)
    end
    
  end
   
end

function InputSystem:update(dt)

  for key, action in pairs(self.input) do
    if love.keyboard.isDown(key) then
      if (self.pressed[key]) then  
        
          for _, act in pairs(action) do
            if (act.action_type == InputSystem.KEY_PRESS) then
              game.events.emit(act.action_name, act.id, unpack(act.params)) 
            end   
          end      
        
      else          
        self.pressed[key] = 0
      end
    elseif (InputSystem.mkey[key] and love.mouse.isDown(InputSystem.mkey[key])) then
       if (self.pressed[key]) then  
        
          for _, act in pairs(action) do
            if (act.action_type == InputSystem.KEY_PRESS) then              
              game.events.emit(act.action_name, act.id, unpack(act.params)) 
            end   
          end      
        
      else          
        self.pressed[key] = 0
      end
    end

  end

  for key, action in pairs(self.pressed) do
    
    if not love.keyboard.isDown(key) and not InputSystem.mkey[key] then
      self.pressed[key] = nil
      local action = self.input[key]
      for _, act in pairs(action) do
        if (act.action_type == InputSystem.KEY_UP) then
          game.events.emit(act.action_name, act.id, unpack(act.params)) 
        end   
      end 
    end
    
    if (InputSystem.mkey[key] and not love.mouse.isDown(InputSystem.mkey[key])) then
      self.pressed[key] = nil
      local action = self.input[key]
      for _, act in pairs(action) do        
        if (act.action_type == InputSystem.KEY_UP) then
          game.events.emit(act.action_name, act.id, love.mouse.getX(), love.mouse.getY(), unpack(act.params)) 
        end   
      end 
    end
    
    if (self.pressed[key]) then
      self.pressed[key] = self.pressed[key] + dt
    end
    
  end
  
end

function InputSystem:onKeyPress(key, unicode)
  
end
