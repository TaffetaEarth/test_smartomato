# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order

  validates_presence_of :url, :name, :price, :quantity, :total_sum
end
