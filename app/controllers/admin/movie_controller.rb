class Admin::MovieController < ApplicationController
def new
    load_data
    @movie = Movie.new
    @page_title = 'Crear pelicula'
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "Pelicula #{@movie.title} fue creada correctamente."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Crear pelicula'
      render :action => 'new'
    end
  end

  def edit
    load_data
    @movie = Movie.find(params[:id])
    @page_title = 'Editar pelicula'
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      flash[:notice] = "Pelicula #{@movie.title} fue editada correctamente."
      redirect_to :action => 'show', :id => @movie
    else
      load_data
      @page_title = 'Editar pelicula'
      render :action => 'edit'
    end
  end
end