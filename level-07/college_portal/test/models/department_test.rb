# frozen_string_literal: true

require 'test_helper'

# Tests for Department model
class DepartmentTest < ActiveSupport::TestCase
  test 'Should define Department model' do
    assert defined? Department
  end

  test 'Should create a new department with name' do
    dept = Department.new name: 'EEE'
    assert dept.save
    assert dept.id
  end

  test 'lower case department must be replaced with upcase' do
    dept = Department.new name: 'eee'
    dept.save
    assert_equal 'EEE', dept.name
  end

  test 'Should not save non-unique departments' do
    dept = Department.new name: 'EEE'
    dept.save
    dept = Department.new name: 'EEE'
    refute dept.save
    assert_equal dept.errors[:name], ['has already been taken']
  end

  test 'Should not save departments with missing names' do
    dept = Department.new
    dept.save
    refute dept.save
    assert_equal dept.errors[:name], ["can't be blank"]
  end
end
