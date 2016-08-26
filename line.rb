class Line
  attr_accessor :stations
  attr_reader :name, :forwards_direction, :backwards_direction

  def initialize(name, forwards_direction = "", backwards_direction = "")
    @name = name
    @forwards_direction = forwards_direction
    @backwards_direction = backwards_direction
    @stations = []
  end

  def [](station_index)
    self.stations[station_index]
  end

  def inspect
    # Grab the normal .to_s for this object so we get the object_id
    # and then tack on our own rendition of the instance variables
    "#{self.to_s[0..-2]}, @name=#{self.name.inspect}, @forwards_direction=#{self.forwards_direction.inspect}, @backwards_direction=#{self.forwards_direction.inspect, @stations=(#{self.stations.count} entries)}>"
  end


  # # Property methods automatically written

  # # Exactly the effect of  attr_reader :name
  # def name
  #   @name
  # end

  # # Exactly the effect of  attr_accessor :stations
  # def stations
  #   @stations
  # end
  # def stations=(val)
  #   @stations = val
  # end
end
