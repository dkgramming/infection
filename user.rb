class User
  @site_version
  @students
  @coach
  attr_accessor :site_version
  attr_accessor :students
  attr_accessor :coach

  def initialize (version)
    @site_version = version
    @students = []
    @coach = nil
  end

  def add_student (student)
    @students.push student
    student.coach = self
  end

  def total_infection
    @students.each do |student| 
      student.site_version = self.site_version

      # Recursively infected students 
      student.total_infection()
    end
  end
end
