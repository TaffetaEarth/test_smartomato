# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject { described_class.new }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:total_sum) }
  end

  describe 'relations' do
    it { is_expected.to belong_to(:order) }
  end
end
