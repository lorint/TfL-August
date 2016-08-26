class Station
  attr_accessor :lines
  attr_reader :name

  def initialize(name, line)
    @name = name
    @lines = [line]
  end

  def [](line_index)
    lines[line_index]
  end

  def <=>(other)
    self.name <=> other.name
  end

  def inspect
    # Grab the normal .to_s for this object so we get the object_id
    # and then tack on our own rendition of the instance variables
    "#{self.to_s[0..-2]}, @name=#{self.name.inspect}, @lines=(#{self.lines.count} entries)}>"
  end

end
