NodeComponent = Class
{
  __includes = Component,
  init = function(self, parent)
    Component.init(self)
    self.id       = "NodeComponent"
    self.children = {}
    self.parent   = parent
  end
}

function NodeComponent:addChild(child)
  table.insert(self.children, child)
end
