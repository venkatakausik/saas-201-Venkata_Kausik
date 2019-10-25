require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test 'Should redirect to home page if not logged in' do
    logout_and_visit('/students')
  end

  test 'Should not show create button for non-admin users' do
    visit '/students'
    assert !page.has_content?('Create')
  end

  test 'Should get all students' do
    visit '/students'
    assert page.has_content?('Students')
  end

  test 'Should navigate to new students on click' do
    login_as_admin do
      visit '/students'
      click_link('Create')
      assert page.has_content?('Create Students')
    end
  end

  test 'Should create new Students' do
    login_as_admin do
      create_students
      assert_equal students_path, current_path
      assert (page.has_content? 'Arjun') || (page.has_content? 'Arjun'.upcase)
    end
  end

  test 'Should display students details' do
    login_as_admin do
      create_students
      click_link 'Arjun'
      assert page.has_content? 'Arjun'
      assert page.has_content? 'Department'
      assert page.has_content? 'Section'
      assert page.has_content? 'A'
    end
  end

  private

  def create_students
    visit '/departments'
    click_link('Create')
    fill_in('department[name]', with: 'NEW DEPT')
    click_on('Create Department')

    visit '/sections'
    click_link('Create')
    fill_in('section[name]', with: 'A')
    select 'New Dept'.upcase, from: 'section[department_id]'
    click_on('Create Section')

    visit '/students'
    click_link('Create')
    fill_in('student[name]', with: 'Arjun')
    fill_in('student[email]', with: 'arjun@dev.com')
    select 'New Dept'.upcase, from: 'student[department_id]'
    select 'A'.upcase, from: 'student[section_id]'
    click_on('Create Student')
  end
end
