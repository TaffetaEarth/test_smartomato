# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  subject { described_class.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:customer_name) }
    it { is_expected.to validate_presence_of(:customer_phone) }
    it { is_expected.to validate_presence_of(:customer_email) }
    it { is_expected.to validate_presence_of(:delivery_address) }
    it { is_expected.to validate_presence_of(:total_sum) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'relations' do
    it { is_expected.to have_many(:order_items) }
  end
end
