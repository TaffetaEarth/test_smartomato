# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.string :url, null: false
      t.string :name, null: false
      t.float :price, null: false
      t.integer :quantity, null: false, default: 1
      t.float :total_sum, null: false
      t.belongs_to :order

      t.timestamps
    end
  end
end
