# frozen_string_literal: true

require 'test_helper'

# Tests for routes
class RoutesTest < ActionDispatch::IntegrationTest
  test 'Should define root properly' do
    assert_generates  '/', controller: 'static_pages', action: 'index'
  end

  test 'Should define department get routes properly' do
    assert_generates  '/departments/new', controller: 'departments', action: 'new'
    assert_generates  '/departments', controller: 'departments', action: 'index'
  end

  test 'Should define sections get routes properly' do
    assert_generates  '/sections/new', controller: 'sections', action: 'new'
    assert_generates  '/sections', controller: 'sections', action: 'index'
  end

  test 'Should define students get routes properly' do
    assert_generates  '/students/new', controller: 'students', action: 'new'
    assert_generates  '/students', controller: 'students', action: 'index'
  end

  test 'Should define create department routes properly' do
    assert_routing({ method: 'post', path: '/departments' },
                   controller: 'departments', action: 'create')
  end

  test 'Should define create sections routes properly' do
    assert_routing({ method: 'post', path: '/sections' },
                   controller: 'sections', action: 'create')
  end

  test 'Should define create-students routes properly' do
    assert_routing({ method: 'post', path: '/students' },
                   controller: 'students', action: 'create')
  end
end

# resources :departments, only: [:index, :show, :create, :new]
# resources :sections, only: [:index, :show, :create, :new]
# resources :students, only: [:index, :show, :create, :new]

# root :to => "static_pages#home"