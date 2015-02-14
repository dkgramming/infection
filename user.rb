class User
  @site_version
  @students
  attr_accessor :site_version
  attr_accessor :students

  def initialize (version)
    @site_version = version
    @students = []
  end

  def add_student (student)
    @students.push student
  end

  def total_infection
    # Iterate over student array and infect them
  end
end
