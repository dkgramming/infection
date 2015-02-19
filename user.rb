require_relative 'counter'

class User
  attr_accessor :site_version
  attr_accessor :students
  attr_accessor :coach
  attr_accessor :infected

  def initialize (version)
    @site_version = version
    @students = []
    @coach = nil
    @infected = false
  end

  def add_student (student)
    @students.push student
    student.coach = self
  end

  def total_infection
    if not @infected then
      
      # The infected flag is set to prevent infinite recursion
      @infected = true

      @students.each do |student| 
        student.site_version = self.site_version

        # Recursively infected students 
        student.total_infection()
      end

      @coach.total_infection() unless @coach.nil?

      # Cure the user so that he/she can receive future infections
      @infected = false
    end
  end

  def limited_infection( counter )
    if not @infected and not counter.zero?
      
      # The infected flag is set to prevent infinite recursion
      @infected = true

      # Signifies that another user has become infected
      counter.decrement!

      @students.each do |student| 
        student.site_version = self.site_version

        # Recursively infected students 
        student.limited_infection( counter )
      end
      
      @coach.limited_infection( counter ) unless @coach.nil?

      # Cure the user so that he/she can receive future infections
      @infected = false
    end
  end
end
