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
end
