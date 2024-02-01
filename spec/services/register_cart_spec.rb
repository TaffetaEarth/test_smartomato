# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sber::RegisterCart do
  describe '.call' do
    let(:form_url) { 'https://some.url' }
    let(:params) { { some_params: :params } }
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
    let(:double_params_service) { instance_double(Sber::GenerateRegisterParams) }

    it 'returns url retrieved from payment system' do
      allow(Sber::GenerateRegisterParams).to receive(:new).with(order:).and_return(double_params_service)
      allow(double_params_service).to receive(:call).and_return(params)

      stub_request(:get,
                   described_class::REQUEST_URL).with(query: params).to_return(body: { formUrl: form_url }.to_json)

      result = described_class.new(order:).call

      expect(result).to eq(form_url)
    end
  end
end
