class Admin::ProducerController < ApplicationController
  def new
    @producer = Producer.new
    @page_title = 'Create new producer'
  end

  def create
    @producer = Producer.new(producer_params)
    if @producer.save
      flash[:notice] = "Producer #{@producer.name} was succesfully created."
      redirect_to :action => 'index'
    else
      @page_title = 'Create new producer'
      render :action => 'new'
    end
  end

  def edit
    @producer = Producer.find(params[:id])
    @page_title = 'Edit producer'
  end

  def update
    @producer = Producer.find(params[:id])
    if @producer.update_attributes(producer_params)
       flash[:notice] = "Producer #{@producer.name} was succesfully updated."
       redirect_to :action => 'show', :id => @producer
    else
       @page_title = 'Edit producer'
       render :action => 'edit'
    end
  end

  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy
    flash[:notice] = "Succesfully deleted producer #{@producer.name}."
    redirect_to :action => 'index'
  end

  def show
    @producer = Producer.find(params[:id])
    @page_title = @producer.name
  end

  def index
    @producers = Producer.all
    @page_title = 'Listing producers'
  end

  private
    def producer_params
      params.require(:producer).permit(:name)
  end
end
