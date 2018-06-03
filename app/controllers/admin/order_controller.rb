class Admin::OrderController < Admin::AuthenticatedController
  def close
    order = Order.find(params[:id])
    order.close
    flash[:notice] = "El pedido ##{order.id} ha sido cerrado."
    redirect_to :action => 'index'
  end

  def show
    @order = Order.find(params[:id])
    @page_title = "Mostrando el pedido ##{@order.id}"
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "El pedido #{@order.id} fue borrado correctamente."
    redirect_to :action => 'index'
  end

  def index
    @status = params[:id]
    if @status.blank?
      @status = 'all'
      conditions = nil
    else
      conditions = "status = '#{@status}'"
    end

    case @status
    when 'all'
      @status = 'todos'
    when "open"
      @status = 'abiertos'
    when "processed"
      @status = 'procesados'
    when "closed"
      @status = 'cerrados'
    when "failed"
      @status = 'fallidos'
    end
    @orders = Order.where(conditions).paginate(:page => params[:page], :per_page => 10)
    @page_title = "Pedidos #{@status}"
  end
end