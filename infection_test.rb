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

    assert_not_equal coach.site_version, student.site_version, 
      "The coach should have a newer version of the site"

    coach.total_infection() 

    assert_equal coach.site_version, student.site_version, 
      "The infection should have spread to the coach's student"
  end

  def test_infect_many_students
    coach = User.new(2)
    student_1 = User.new(0)
    student_2 = User.new(0)
    student_3 = User.new(0)
    coach.add_student( student_1 )
    coach.add_student( student_2 )
    coach.add_student( student_3 )

    coach.students.each do |student|
      assert_not_equal coach.site_version, student.site_version, 
        "The coach should have a newer version of the site"
    end

    coach.total_infection()

    coach.students.each do |student|
      assert_equal coach.site_version, student.site_version, 
        "The infection should have spread to the coach's students"
    end
  end

  def test_infect_student_of_student
    coach = User.new(5)
    coach_student= User.new(3)
    student = User.new(2)
    
    coach.add_student( coach_student )
    coach_student.add_student( student )

    assert_not_equal coach.site_version, student.site_version, 
      "The coach should have a newer version of the site"

    coach.total_infection()

    assert_equal coach.site_version, student.site_version,
      "The coach should have transitively infected the student"
  end

  def test_student_infect_coach
    coach = User.new(3)
    student = User.new(4)
    
    coach.add_student( student )

    assert_not_equal coach.site_version, student.site_version, 
      "The student's site version should be higher than the coach's"

    student.total_infection()

    assert_equal coach.site_version, student.site_version,
      "The student should have infected the coach with the newer site version"
  end

  def test_student_infect_coachs_student
    coach_a = User.new(0)
    student_a = User.new(4)
    student_b = User.new(0)

    coach_a.add_student( student_a )
    coach_a.add_student( student_b )

    assert_not_equal student_a.site_version, student_b.site_version, 
      "Student A should have a newer version of the site"

    student_a.total_infection()

    assert_equal student_a.site_version, student_b.site_version, 
      "Student A should have the same version of the site as Student B"
  end

  def test_limited_infection_five
    coach_a = User.new(12)
    coach_b = User.new(10)
    coach_c = User.new(9)
    student_a = User.new(5)
    student_b = User.new(6)
    student_c = User.new(4)

    coach_b.add_student( student_a )
    coach_b.add_student( student_b )

    coach_c.add_student( student_c )

    coach_a.add_student( coach_b )
    coach_a.add_student( coach_c )

    # The counter allow Coach A to infect four other users, total of five
    coach_a.limited_infection( Counter.new(5) )

    assert_equal coach_a.site_version, coach_c.site_version,
      "Coach C should have been infected."

    assert_equal coach_a.site_version, coach_b.site_version,
      "Coach B should have been infected."
      
    assert_equal coach_a.site_version, student_b.site_version,
      "Student B should have been infected."

    assert_equal coach_a.site_version, student_a.site_version,
      "Student A should have been infected."

    assert_not_equal coach_a.site_version, student_c.site_version,
      "Coach A's infection should only spread to 4 users, student C is the fifth"
  end

  def test_limited_infected_not_possible
    coach = User.new(23)
    student = User.new(20)

    coach.add_student( student )

    # Try to infect two other users
    counter_remainder = coach.limited_infection( Counter.new(3) )

    assert_respond_to counter_remainder, :integer?, 
      "Limited infected should return an integer"

    assert_not_equal 0, counter_remainder, 
      "Counter should have a remainder since Coach tried to infect two users."
  end

  def test_counter_zero
    counter = Counter.new(0)
    assert counter.zero?, 
      "The counter should be zero since it was initialized to zero" 
  end

  def test_counter_zero_from_decrement
    counter = Counter.new(5)

    assert counter.count == 5, "The counter was initialized to five."

    5.times do
      counter.decrement!
    end

    assert counter.zero?, "The counter should have decremented to zero"
  end
end
