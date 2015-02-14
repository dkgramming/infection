require_relative 'user'
require 'test/unit'

class UserTest < Test::Unit::TestCase

  def test_initialize_version
    new_user = User.new(0)
    assert_not_nil new_user.site_version, "This user has no site version number."
  end

  def test_add_one_student
    coach = User.new(0)
    student = User.new(0)
    coach.add_student( student )
    assert_equal 1, coach.students.length, "The coach should have exactly one student" 
  end

  def test_add_many_students
    coach = User.new(0)
    student1 = User.new(0)
    student2 = User.new(0)
    student3 = User.new(0)
    coach.add_student( student1 )
    coach.add_student( student2 )
    coach.add_student( student3 )
    assert_equal 3, coach.students.length, "The coach should have exactly three student" 
  end

  def test_student_coach_bidirectional
    assert false, "Test not implemented"
  end

  def test_infect_one_student
    assert false, "Test not implemented"
  end
end
