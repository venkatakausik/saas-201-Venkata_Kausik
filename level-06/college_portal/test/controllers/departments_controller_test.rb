require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  test 'Should get all departments' do
    visit '/departments'
    assert page.has_content?('Departments')
  end

  test 'Should navigate to new department on click' do
    visit '/departments'
    click_link('Create')
    assert page.has_content?('Create Department')
  end

  test 'Should create new department' do
    visit '/departments'
    click_link('Create')
    fill_in('department[name]', with: 'New Dept')
    click_on('Create Department')
    assert_equal current_path, departments_path
    assert (page.has_content? 'New Dept') || (page.has_content? 'New Dept'.upcase)
  end
end
