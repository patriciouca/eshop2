class Admin::DirectorController < ApplicationController
def new
    @director = Director.new
    @page_title = 'Crear nuevo director'
  end

  def create
    @director = Director.new(director_params)
    if @director.save
      flash[:notice] = "Director #{@director.name} fue creado correctamente."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nuevo director'
      render :action => 'new'
    end
  end

  def edit
    @director = Director.find(params[:id])
    @page_title = 'Editar director'
  end

  def update
    @director = Director.find(params[:id])
    if @director.update_attributes(director_params)
      flash[:notice] = "Director #{@director.name} fue editado con exito."
      redirect_to :action => 'show', :id => @director
    else
      @page_title = 'Editar director'
      render :action => 'edit'
    end
  end

  def destroy
    @director = Director.find(params[:id])
    @director.destroy
    flash[:notice] = "Fue eliminado correctamente el director #{@director.name}."
    redirect_to :action => 'index'
  end

  def show
    @director = Director.find(params[:id])
    @page_title = @director.name
  end

  def index
    @directors = Director.all
    @page_title = 'Listar directores'
  end

  private
    def director_params
      params.require(:director).permit(:first_name, :last_name)
    end
end
