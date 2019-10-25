require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  test 'Should redirect to home page if not logged in' do
    logout_and_visit('/departments')
  end

  test 'Should not show create button for non-admin users' do
    visit '/departments'
    assert !page.has_content?('Create')
  end

  test 'Should get all departments' do
    user = User.new(email: 'test@test.com', password: 'abc123')
    user.save!
    login_as(user, :scope => :user)
    visit '/departments'
    assert page.has_content?('Departments')
  end

  test 'Should navigate to new department on click' do
    login_as_admin do
      visit '/departments'
      click_link('Create')
      assert page.has_content?('Create Department')
    end
  end

  test 'Should create new department' do
    login_as_admin do
      visit '/departments'
      click_link('Create')
      fill_in('department[name]', with: 'New Dept')
      click_on('Create Department')
      assert_equal current_path, departments_path
      assert (page.has_content? 'New Dept') || (page.has_content? 'New Dept'.upcase)
    end
  end
end
