class User
  @site_version
  @students = []
  attr_accessor :site_version

  def initialize (version)
    @site_version = version
  end

  def total_infection
    # Iterate over student array and infect them
  end
end
