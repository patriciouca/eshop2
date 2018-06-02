#encoding: utf-8
class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => :show
  #before_filter :require_no_user

  def show
    @movie = Movie.find(params[:id])
    @page_title = @movie.title
  end

  def index
    @movies = Movie.order("movies.id desc").includes(:directors, :producer).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Catálogo'
  end

  def latest
    @movies = Movie.latest 5 # invoques "latest" method to get the five latest movies
    @page_title = 'Últimas peliculas'
  end

  def rss
    latest
    render :layout => false
    response.headers["Content-Type"] = "application/xml; version=1.0; charset=utf-8"
  end
end
