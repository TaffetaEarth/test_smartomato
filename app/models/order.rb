# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items

  enum status: %i[draft paid payment_error waiting_for_payment]

  validates_presence_of :customer_name, :customer_phone, :customer_email, :delivery_address, :total_sum, :status
end
