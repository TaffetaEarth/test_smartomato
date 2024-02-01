# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(order_params[:id])
  end

  def checkout
    order = Order.find(checkout_params[:order_id])
    form_url = Sber::RegisterCart.new(order:).call
    order.waiting_for_payment!
    # render json: { payment_url: form_url }, status: 200
    redirect_to form_url, allow_other_host: true
  rescue JSON::ParserError, HTTP::TimeoutError, HTTP::ConnectionError => e
    render json: { error: e.message }, status: 400
  end

  def callback
    order = Order.find_by!(id: callback_params[:orderNumber])

    case params[:status]
    when 1 then order.paid!
    when 0 then order.payment_error!
    end
    render status: 200
  rescue ActiveRecord::RecordNotFound
    render status: 404, json: { error: 'Order not found' }
  end

  private

  def checkout_params
    params.permit(:order_id, :id, :commit, :authenticity_token)
  end

  def callback_params
    params.permit(:orderNumber, :mdOrder, :sign_alias,
                  :callbackCreationDate, :operation, :status)
  end

  def order_params
    params.permit(:id)
  end
end
