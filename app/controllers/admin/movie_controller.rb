 #encoding: utf-8
class Admin::MovieController < Admin::AuthenticatedController
def new
    load_data
    @movie = Movie.new
    @page_title = 'Crear película'
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      flash[:notice] = "Película #{@movie.title} fue creada correctamente."
      redirect_to :action => 'index'
    else
      load_data
      @page_title = 'Crear película'
      render :action => 'new'
    end
  end

    def edit
    load_data
    @movie = Movie.find(params[:id])
    @page_title = 'Editar película'
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      flash[:notice] = "Película #{@movie.title} fue actualizada correctamente."
      redirect_to :action => 'show', :id => @movie
    else
      load_data
      @page_title = 'Editar película'
      render :action => 'edit'
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Fue borrada la película #{@movie.title}."
    redirect_to :action => 'index'
  end

  def show
    @movie = Movie.find(params[:id])
    @page_title = @movie.title
  end

  def index
    sort_by = params[:sort_by]
    @movies = Movie.order(sort_by).paginate(:page => params[:page], :per_page => 5)
    @page_title = 'Películas'
  end

  private

    def load_data
      @directors = Director.all
      @producers = Producer.all
    end

    def movie_params
      params.require(:movie).permit(:title, :producer_id, :produced_at, { :director_ids => [] },
                                   :serial_number, :blurb, :price, :length, :cover_image)
    end
end