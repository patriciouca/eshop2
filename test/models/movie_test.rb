require File.dirname(__FILE__) + '/../test_helper'

class MovieTest < ActiveSupport::TestCase
  fixtures :directors, :producers, :movies, :directors_movies

  test "failing_create" do
    movie = Movie.new
    assert_equal false, movie.save
    assert_equal 7, movie.errors.count
    assert movie.errors[:title]
    assert movie.errors[:producer]
    assert movie.errors[:authors]
    assert movie.errors[:produced_at]
    assert movie.errors[:serial_number]
    assert movie.errors[:blurb]
    assert movie.errors[:length]
    assert movie.errors[:price]
  end

  test "create" do
    #Producer.create(name=>'hola')
    movie = Movie.new(
      :title => 'Ruby on Rails',
      :directors => Director.all,
      :producer_id => Producer.find(1).id,
      :produced_at => Time.now,
      :serial_number => "12425",
      :blurb => 'A great movie',
      :length => 375,
      :price => 45.5
    )
    assert movie.save
  end

  test "has_many_and_belongs_to_mapping" do
    apress = Producer.find_by_name("Apress");
    count = apress.movies.count
    movie = Movie.new(
      :title => 'Pro Rails E-Commerce 8th Edition',
      :directors => [Director.find_by_first_name_and_last_name('Joel', 'Spolsky'),
                   Director.find_by_first_name_and_last_name('Jeremy', 'Keith')],
      #:producer_id => apress.id,
      :produced_at => Time.now,
      :serial_number => '12134',
      :blurb => 'E-Commerce on Rails',
      :length => 400,
      :price => 55.5
    )
    apress.movies << movie
    apress.reload
    movie.reload
    assert_equal count + 1, apress.movies.count
    assert_equal 'Apress', movie.producer.name
  end

  test "has_many_and_belongs_to_many_directors_mapping" do
    movie = Movie.new(
      :title => 'Pro Rails E-Commerce 8th Edition',
      :directors => [Director.find_by_first_name_and_last_name('Joel', 'Spolsky'),
                   Director.find_by_first_name_and_last_name('Jeremy', 'Keith')],
      :producer_id => Producer.find_by_name("Apress").id,
      :produced_at => Time.now,
      :serial_number => '65321',
      :blurb => 'E-Commerce on Rails',
      :length => 400,
      :price => 55.5
    )
    assert movie.save
    movie.reload
    assert_equal 2, movie.directors.count
    assert_equal 2, Director.find_by_first_name_and_last_name('Joel', 'Spolsky').movies.count
  end
end