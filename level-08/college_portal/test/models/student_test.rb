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

  test 'Should fail students for missing required properties' do
    student = Student.new
    refute student.save
    assert_equal student.errors[:name], ["can't be blank"]
    assert_equal student.errors[:section_id], ["can't be blank"]
    assert_equal student.errors[:department_id], ["can't be blank"]
  end

  test 'Should fail students for bad section and department_id' do
    student = Student.new name: 'fw', department_id: 1, section_id: 1
    refute student.save
    assert_equal student.errors[:section].first, 'must exist'
    assert_equal student.errors[:department].first, 'must exist'
  end

  test 'Should generate roll_no for students' do
    sect = Section.new name: 'A'
    dept = Department.new name: 'MECH'
    dept.save
    sect.department = dept
    sect.save
    student = Student.new name: 'fw', department_id: dept.id, section_id: sect.id
    student.save
    assert_equal "#{dept.name.downcase}-#{sect.name.downcase}-#{Student.all.size}",
                 student.roll_no
  end
end
