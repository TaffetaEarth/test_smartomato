# frozen_string_literal: true

module Sber
  class GenerateRegisterParams
    TOKEN = Rails.application.credentials.dig(:sber, :token)
    RETURN_URL = Rails.application.credentials.dig(:sber, :return_url)

    def initialize(order:)
      @order = order
    end

    def call
      {
        token: TOKEN,
        order_number: order.id,
        amount: order.total_sum,
        returnUrl: RETURN_URL,
        orderBundle: order_bundle
      }
    end

    private

    attr_reader :order

    def order_bundle
      { cartItems: cart_items }
    end

    def cart_items
      order.order_items.map do
        {
          postionId: _1.id,
          name: _1.name,
          quantity: _1.quantity,
          itemCode: _1.id
        }
      end
    end
  end
end
