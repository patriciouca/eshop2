require 'test_helper'

class Admin::DirectorControllerTest < ActionController::TestCase
 fixtures :directors

  test "new" do
    get :new
    assert_template 'admin/director/new'
    assert_select 'div#content' do
      assert_select 'h1', 'Create new director'
      assert_select "form[action=\"/admin/director/create\"]"
    end
    
  end

  test "create" do
    get :new
    assert_template 'admin/director/new'
    assert_difference(Director, :count) do
      post :create, :director => {:first_name => 'Joel', :last_name => 'Spolsky'}
      assert_response :redirect
      assert_redirected_to :action => 'index'
    end
    assert_equal 'Director Joel Spolsky fue creado correctamente.', flash[:notice]
  end

  test "failing_create" do
    assert_no_difference(Director, :count) do
      post :create, :director => {:first_name => 'Joel'}
      assert_response :success
      assert_template 'admin/director/new'
      assert_select "div[class=\"field_with_errors\"]"
      
    end
  end

  test "edit" do
    get :edit, :id => 1
    assert_select 'input' do
      assert_select '[type=?]', 'text'
      assert_select '[name=?]', 'director[first_name]'
      assert_select '[value=?]', 'Joel'
    end
    assert_select 'input' do
      assert_select '[type=?]', 'text'
      assert_select '[name=?]', 'director[last_name]'
      assert_select '[value=?]', 'Spolsky'
    end
  end

  test "update" do
    post :update, :id => 1, :director => { :first_name => 'Joseph', :last_name => 'Spolsky' }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Joseph', Director.find(1).first_name
  end

  test "test_destroy" do
    assert_difference(Director, :count, -1) do
      post :destroy, :id => 1
      assert_equal flash[:notice], 'Fue eliminado correctamente el director Joel Spolsky.'
      assert_response :redirect
      assert_redirected_to :action => 'index'
      get :index
      assert_response :success
      assert_select 'div#notice', 'Fue eliminado correctamente el director Joel Spolsky.'
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/director/show'
    assert_equal 'Joel', assigns(:director).first_name
    assert_equal 'Spolsky', assigns(:director).last_name
    assert_select 'div#content' do
      assert_select 'h1', Director.find(1).name
    end
  end

  test "index" do
    get :index
    assert_response :success
    assert_select 'table' do
      assert_select 'tr', Director.count + 1
    end
    Director.find_each do |a|
      assert_select 'td', a.name
    end
  end
end
