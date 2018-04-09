class Admin::ProducerController < ApplicationController
  def new
    @producer = Producer.new
    @page_title = 'Crear nuevo productor'
  end

  def create
    @producer = Producer.new(producer_params)
    if @producer.save
      flash[:notice] = "El productor #{@producer.name} ha sido actualizado con éxito."
      redirect_to :action => 'index'
    else
      @page_title = 'Crear nuevo productor'
      render :action => 'new'
    end
  end

  def edit
    @producer = Producer.find(params[:id])
    @page_title = 'Editar productor'
  end

  def update
    @producer = Producer.find(params[:id])
    if @producer.update_attributes(producer_params)
       flash[:notice] = "El productor #{@producer.name} ha sido actualizado con exito."
       redirect_to :action => 'show', :id => @producer
    else
       @page_title = 'Editar Productor'
       render :action => 'edit'
    end
  end

  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy
    flash[:notice] = "Productor eliminado con exito #{@producer.name}."
    redirect_to :action => 'index'
  end

  def show
    @producer = Producer.find(params[:id])
    @page_title = @producer.name
  end

  def index
    @producers = Producer.all
    @page_title = 'Lista Productores'
  end

  private
    def producer_params
      params.require(:producer).permit(:name)
  end
end