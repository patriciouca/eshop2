require File.dirname(__FILE__) + '/../test_helper'

class MovieAdministrationTest < ActionDispatch::IntegrationTest

  test "movie_aministration" do
    producer = Producer.create(:name => 'Movies of Ruby')
    director = Director.create(:first_name => 'John', :last_name => 'Anderson')
    george = new_session_as(:george)

    new_movie_ruby = george.add_movie :movie => {
      :title => 'A new Movie of Ruby',
      :producer_id => producer.id,
      :director_ids => [director.id],
      :produced_at => Time.now,
      :serial_number => '64214',
      :blurb => 'A new Movie of Ruby',
      :length => 325,
      :price => 45.5
    }

    george.list_movies
    george.show_movie new_movie_ruby

    george.edit_movie new_movie_ruby, :movie => {
      :title => 'A very new Movie of Ruby',
      :producer_id => producer.id,
      :director_ids => [director.id],
      :produced_at => Time.now,
      :serial_number => '43214',
      :blurb => 'A very new Movie of Ruby',
      :length => 350,
      :price => 50
    }

    bob = new_session_as(:bob)
    bob.delete_movie new_movie_ruby
  end

  private

  module MovieTestDSL
    attr_writer :name

    def add_movie(parameters)
      director = Director.first
      producer = Producer.first
      get '/admin/movie/new'
      assert_response :success
      assert_template 'admin/movie/new'
      assert_select 'select#movie_producer_id' do
        assert_select "option[value=\"#{producer.id}\"]", producer.name
      end
      # assert_tag :tag => 'option', :attributes => { :value => producer.id }
      assert_select "select[name=\"movie[director_ids][]\"]" do
        assert_select "option[value=\"#{director.id}\"]", director.name
      end
      # assert_tag :tag => 'select', :attributes => { :name => 'movie[director_ids][]' }
      
      post '/admin/movie/create', parameters
      assert_response :redirect
      follow_redirect!

      get '/admin/movie/index'
      assert_response :success
      assert_template 'admin/movie/index'
      page = Movie.all.count / 5 + 1
      get "/admin/movie/index/?page=#{page}"
      assert_select 'td', parameters[:movie][:title]

      # assert_tag :tag => 'td', :content => parameters[:movie][:title]

      movie = Movie.find_by_title(parameters[:movie][:title])
      return movie;
    end

    def edit_movie(movie, parameters)
      get "/admin/movie/edit?id=#{movie.id}"
      assert_response :success
      assert_template 'admin/movie/edit'
      post "/admin/movie/update?id=#{movie.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/movie/show'
    end

    def delete_movie(movie)
      post "/admin/movie/destroy?id=#{movie.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/movie/index'
    end

    def show_movie(movie)
      get "/admin/movie/show/#{movie.id}"
      assert_response :success
      assert_template 'admin/movie/show'
    end

    def list_movies
      get '/admin/movie/index'
      assert_response :success
      assert_template 'admin/movie/index'
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(MovieTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
