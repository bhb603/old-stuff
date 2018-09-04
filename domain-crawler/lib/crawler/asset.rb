class Asset
  attr_accessor :type, :loc
  
  def initialize(type, loc)
    @type = type
    @loc = loc
  end
end
