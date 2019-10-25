require 'test_helper'

class SectionsControllerTest < ActionDispatch::IntegrationTest
  test 'Should redirect to home page if not logged in' do
    logout_and_visit('/sections')
  end

  test 'Should not show create button for non-admin users' do
    visit '/students'
    assert !page.has_content?('Create')
  end

  test 'Should get all sections' do
    visit '/sections'
    assert page.has_content?('Sections')
  end

  test 'Should navigate to new section on click' do
    login_as_admin do
      visit '/sections'
      click_link('Create')
      assert page.has_content?('Create Section')
    end
  end

  test 'Should create new section' do
    login_as_admin do
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
end
