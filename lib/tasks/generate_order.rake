# frozen_string_literal: true

require 'order_params_builder'

desc 'Generates random order with some random items'
task generate_order: [:environment] do
  params_builder = OrderParamsBuilder.new

  order = Order.create!(params_builder.order_params)

  3.times do
    OrderItem.create!(params_builder.order_item_params.merge(order:))
  end
end
