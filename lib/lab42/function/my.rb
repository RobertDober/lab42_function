module Lab42::Function::My
  
  def my_class_method *args
    Lab42::Function::partial(self.class, *args)
  end

  def my_method *args
    Lab42::Function::partial(self, *args)
  end
end
