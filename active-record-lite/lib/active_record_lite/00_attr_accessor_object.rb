require 'debugger'

class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      my_attr_reader(name)
      my_attr_setter(name)
    end
  end

  def self.my_attr_reader(*names)

    reader = name.to_s

    names.each do |name|
      reader = "@#{name.to_s}"
      define_method(name) { instance_variable_get(reader) }
    end
  end

  def self.my_attr_setter(*names)
    names.each do |name|
      setter = "@#{name.to_s}"
      meth_name = "#{name.to_s}=".to_sym
      define_method(meth_name) { |x| instance_variable_set(setter, x) }
    end

  end

end
