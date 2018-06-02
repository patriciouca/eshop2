class CartController < ApplicationController
  before_filter :initialize_cart

  def add
    @movie = Movie.find params[:id]
    @page_title = 'Añadir película'
    respond_to do |format|
      format.js { 
        @item = @cart.add params[:id]
        flash.now[:cart_notice] = "Añadido <em>#{@item.movie.title}</em>."
        render :controller => 'cart', :action => 'add_with_ajax'
        }
      format.html { 
        if request.post?
          @item = @cart.add params[:id]
          flash[:cart_notice] = "Añadido <em>#{@item.movie.title}</em>."
          redirect_to :controller => 'catalog'
        else
          render :controller => 'cart', :action => 'add', :template => 'cart/add'
        end
        }
    end
  end

  def remove
    @movie = Movie.find params[:id]
    @page_title = 'Borrar película'
    respond_to do |format|
      format.js { 

          @item = @cart.remove params[:id]
          flash[:cart_notice] = "Borrado 1 <em>#{@item.movie.title}</em>."
          render :controller => 'cart', :action => 'remove_with_ajax'

      }
      format.html { 
        if request.post?
          @item = @cart.remove params[:id]
          flash[:cart_notice] = "Borrado 1 <em>#{@item.movie.title}</em>."
          redirect_to :controller => 'catalog'
        else
          render :controller => 'cart', :action => 'remove'
        end
      }
    end
    
  end

  def clear
    @page_title = 'Vaciar carrito'
    respond_to do |format|
      format.js { 

          @cart.cart_items.destroy_all
          flash.now[:cart_notice] = "Vaciado del carrito."
          render :controller => 'cart', :action => 'clear_with_ajax'

      }
      format.html { 
        if request.post?
        @cart.cart_items.destroy_all
        flash[:cart_notice] = "Vaciado del carrito."
        redirect_to :controller => 'catalog'
      else
        render :controller => 'cart', :action => 'clear'
      end
      }
    end
    
  end
end
