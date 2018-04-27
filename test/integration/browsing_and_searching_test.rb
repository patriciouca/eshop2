require File.dirname(__FILE__) + '/../test_helper'

class BrowsingAndSearchingTest < ActionDispatch::IntegrationTest
  fixtures :producers, :directors, :movies, :directors_movies

  test "browse" do
    jill = new_session_as :jill
    jill.index
    jill.second_page
    jill.movie_details 'Pride and Prejudice'
    jill.latest_movies
  end

  module BrowsingTestDSL
    include ERB::Util
    attr_writer :name

    def index
      get '/catalog/index'
      assert_response :success
      assert_select 'dl#movies' do
        assert_select 'dt', :count => 5
      end
      # assert_tag :tag => 'dl', :attributes => { :id => 'movies' },
      #            :children => { :count => 5, :only => { :tag => 'dt' }}
      assert_select 'dt' do
        assert_select 'a', 'The Idiot'
      end
      # assert_tag :tag => 'dt', :content => 'The Idiot'
      check_movie_links
    end

    def second_page
      get '/catalog/index?page=2'
      assert_response :success
      assert_template 'catalog/index'
      assert_equal movie.find_by_title('Pro Rails E-Commerce'),
                   assigns(:movies).last
      check_movie_links
    end

    def movie_details(title)
      @movie = movie.where(:title => title).first
      get "/catalog/show/#{@movie.id}"
      assert_response :success
      assert_template 'catalog/show'
      assert_select 'div#content' do
        assert_select 'h1', @movie.title
        assert_select 'h2', "by #{@movie.directors.map{|a| a.name}.join(", ")}"
      end
      # assert_tag :tag => 'h1', :content => @movie.title
      # assert_tag :tag => 'h2', :content => "by #{@movie.directors.map{|a| a.name}.join(", ")}"
    end

    def latest_movies
      get '/catalog/latest'
      assert_response :success
      assert_template 'catalog/latest'
      assert_select 'dl#movies' do
        assert_select 'dt', :count => 5
      end
      # assert_tag :tag => 'dl', :attributes => { :id => 'movies' },
      #            :children => { :count => 5, :only => { :tag => 'dt' } }
      @movies = movie.latest(5)
      @movies.each do |a|
        assert_select 'dt' do
          assert_select 'a', a.title
        end
        # assert_tag :tag => 'dt', :content => a.title
      end
    end

    def check_movie_links
      for movie in assigns :movies
        assert_select 'a' do
          assert_select '[href=?]', "/catalog/show/#{movie.id}"
        end
        # assert_tag :tag => 'a', :attributes => { :href => "/catalog/show/#{movie.id}" }
      end
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
