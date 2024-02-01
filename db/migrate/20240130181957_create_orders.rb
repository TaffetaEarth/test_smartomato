# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.string :customer_phone, null: false
      t.string :customer_email, null: false
      t.string :delivery_address, null: false
      t.float :total_sum, null: false
      t.integer :status, null: false, default: 0
      t.string :payment_system_metadata

      t.timestamps
    end
  end
end
