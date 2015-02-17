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
    coach = User.new(0)
    student = User.new(0)
    coach.add_student( student )
    assert_equal coach, student.coach, "The student should have a reference to its coach"
  end

  def test_infect_one_student
    # Put the coach three versions ahead of the student
    coach = User.new(3)
    student = User.new(0)
    coach.add_student( student )

    coach.total_infection() 

    assert_equal coach.site_version, student.site_version, 
      "The infection should have spread to the coach's student"
  end
end
