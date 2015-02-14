require_relative 'user'
require 'test/unit'

class UserTest < Test::Unit::TestCase

  def test_initialize_version
    new_user = User.new(0)
    assert_not_nil new_user.site_version, "This user has no site version number."
  end

  def test_add_one_student
    assert false, "Test not implemented"
  end

  def test_add_many_students
    assert false, "Test not implemented"
  end

  def test_infect_one_student
    assert false, "Test not implemented"
  end
end
