# frozen_string_literal: true

require 'test_helper'

# Tests for Student model
class StudentTest < ActiveSupport::TestCase
  test 'Should define student model' do
    assert defined? Student
  end

  test 'Should define name' do
    assert Student.column_names.include? 'name'
  end

  test 'Should define roll_no' do
    assert Student.column_names.include? 'roll_no'
  end

  test 'Should define email' do
    assert Student.column_names.include? 'email'
  end

  test 'Should create a student and persist' do
    sect = Section.new name: 'A'
    dept = Department.new name: 'MECH'
    dept.save
    sect.department = dept
    sect.save
    student = Student.new name: 'A', roll_no: 1, email: 'asd@email.com',
                          department: dept, section: sect
    assert student.save
  end

  test 'Deleting a department should delete all students' do
    sect = Section.new name: 'A'
    dept = Department.new name: 'MECH'
    dept.save
    sect.department = dept
    sect.save
    student = Student.new name: 'A', roll_no: 1, email: 'asd@email.com',
                          department: dept, section: sect
    student.save
    dept.destroy
    assert_raises ActiveRecord::RecordNotFound do
      Student.find student.id
    end
  end

  test 'Deleting a section should delete all students' do
    sect = Section.new name: 'A'
    dept = Department.new name: 'MECH'
    dept.save
    sect.department = dept
    sect.save
    student = Student.new name: 'A', roll_no: 1, email: 'asd@email.com',
                          department: dept, section: sect
    student.save
    sect.destroy
    assert_raises ActiveRecord::RecordNotFound do
      Student.find student.id
    end
  end
end
