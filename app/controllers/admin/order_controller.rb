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
      @status = 'todo'
    when "open"
      @status = 'abierto'
    when "processed"
      @status = 'procesado'
    when "closed"
      @status = 'cerrado'
    when "failure"
      @status = 'fallado'
    end
    @orders = Order.where(conditions).paginate(:page => params[:page], :per_page => 10)
    @page_title = "Pedidos #{@status}"
  end
end