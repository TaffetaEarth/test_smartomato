# frozen_string_literal: true

require 'ffaker'

class OrderParamsBuilder
  def order_params
    {
      customer_name: FFaker::NameRU.name,
      customer_phone: FFaker::PhoneNumberRU.phone_number,
      customer_email: FFaker::Internet.email,
      delivery_address: "#{FFaker::AddressRU.province}, #{FFaker::AddressRU.city}, #{FFaker::AddressRU.street_address}",
      total_sum: FFaker::Number.decimal
    }
  end

  def order_item_params
    {
      url: FFaker::Internet.http_url,
      name: FFaker::LoremRU.word.capitalize,
      price: FFaker::Number.decimal,
      quantity: FFaker::Number.number,
      total_sum: FFaker::Number.decimal
    }
  end
end
