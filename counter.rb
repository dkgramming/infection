class Counter
  attr_accessor :count
  
  def initialize( count )
    @count = count
  end

  def decrement!
    @count -= 1
  end

  def zero?
    @count == 0
  end

end
