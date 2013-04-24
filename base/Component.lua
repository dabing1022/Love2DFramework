Component = Class
{
  init = 
    function(self, id)
      self.id     = id
      self.entity = nil
    end
}

function Component:addEntity(entity)
  self.entity = entity
end

function Component:update(dt)
  
end

function Component:draw()
  
end
