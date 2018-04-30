class CartController < ApplicationController
  before_filter :initialize_cart

  def add
    @movie = Movie.find params[:id]
    @page_title = 'Añadir película'
    if request.post?
      @item = @cart.add params[:id]
      flash[:cart_notice] = "Añadido <em>#{@item.movie.title}</em>."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'add', :template => 'cart/add'
    end
  end

  def remove
    @movie = Movie.find params[:id]
    @page_title = 'Borrar película'
    if request.post?
      @item = @cart.remove params[:id]
      flash[:cart_notice] = "Borrado 1 <em>#{@item.movie.title}</em>."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'remove'
    end
  end

  def clear
    @page_title = 'Vaciar carrito'
    if request.post?
      @cart.cart_items.destroy_all
      flash[:cart_notice] = "Vaciado del carrito."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'clear'
    end
  end
end
