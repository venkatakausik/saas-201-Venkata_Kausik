# frozen_string_literal: true

require 'test_helper'

# Tests for Section model
class SectionTest < ActiveSupport::TestCase
  test 'Should define section model' do
    assert defined? Section
  end

  test 'Should create a new section with name' do
    sect = Section.new name: 'A'
    dept = Department.new name: 'EEE'
    dept.save
    sect.department = dept
    assert sect.save
    assert sect.id
  end

  test 'Deleting a department should delete all sections' do
    sect = Section.new name: 'A'
    dept = Department.new name: 'MECH'
    dept.save
    sect.department = dept
    sect.save
    assert dept.destroy
    assert_raises ActiveRecord::RecordNotFound do
      Section.find sect.id
    end
  end
end
