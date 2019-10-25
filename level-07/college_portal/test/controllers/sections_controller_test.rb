require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  test 'Should get all sections' do
    visit '/sections'
    assert page.has_content?('Sections')
  end

  test 'Should navigate to new section on click' do
    visit '/sections'
    click_link('Create')
    assert page.has_content?('Create Section')
  end

  test 'Should create new section' do
    visit '/departments'
    click_link('Create')
    fill_in('department[name]', with: 'NEW DEPT')
    click_on('Create Department')
    visit '/sections'
    click_link('Create')
    fill_in('section[name]', with: 'A')
    select 'New Dept'.upcase, from: 'section[department_id]'
    click_on('Create Section')
    assert_equal current_path, sections_path
    assert page.has_content?('A')
  end
end
