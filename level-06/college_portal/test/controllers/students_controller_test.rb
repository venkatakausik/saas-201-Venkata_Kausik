require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test 'Should get all students' do
    visit '/students'
    assert page.has_content?('Students')
  end

  test 'Should navigate to new students on click' do
    visit '/students'
    click_link('Create')
    assert page.has_content?('Create Students')
  end

  test 'Should create new Students' do
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
    select 'New Dept'.upcase, from: 'student[department_id]'
    select 'A'.upcase, from: 'student[section_id]'
    click_on('Create Student')
    assert_equal current_path, students_path
    assert (page.has_content? 'Arjun') || (page.has_content? 'Arjun'.upcase)
  end

  test 'Should list students details' do
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
    select 'New Dept'.upcase, from: 'student[department_id]'
    select 'A'.upcase, from: 'student[section_id]'
    click_on('Create Student')

    click_on 'Arjun'
    assert page.has_content? 'Arjun'
    assert page.has_content? 'Department'
    assert page.has_content? 'Section'
    assert page.has_content? 'A'
  end
end
