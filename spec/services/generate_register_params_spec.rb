# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sber::GenerateRegisterParams do
  describe '.call' do
    let(:order_params) do
      {
        customer_name: FFaker::NameRU.name,
        customer_phone: FFaker::PhoneNumberRU.phone_number,
        customer_email: FFaker::Internet.email,
        delivery_address: "#{FFaker::AddressRU.province}, #{FFaker::AddressRU.city}, #{FFaker::AddressRU.street_address}",
        total_sum: FFaker::Number.decimal
      }
    end
    let(:order) { Order.create(order_params) }
    let(:order_item_params) do
      {
        url: FFaker::Internet.http_url,
        name: FFaker::LoremRU.word.capitalize,
        price: FFaker::Number.decimal,
        quantity: FFaker::Number.number,
        total_sum: FFaker::Number.decimal,
        order:
      }
    end
    let!(:order_item) { OrderItem.create!(order_item_params) }
    let(:cart_items) do
      {
        postionId: order_item.id,
        name: order_item.name,
        quantity: order_item.quantity,
        itemCode: order_item.id
      }
    end

    it 'returns valid params' do
      result = described_class.new(order:).call

      expect(result[:order_number]).to eq(order.id)
      expect(result[:amount]).to eq(order.total_sum)
      expect(result[:orderBundle]).to include({ cartItems: [cart_items] })
    end
  end
end
