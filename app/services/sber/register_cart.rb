# frozen_string_literal: true

require 'http'

module Sber
  class RegisterCart
    REQUEST_URL = Rails.application.credentials.dig(:sber, :request_url)

    def initialize(order:)
      @order = order
    end

    def call
      response_body = HTTP.get("#{REQUEST_URL}?#{register_params.to_query}").body
      parsed_body = JSON.parse(response_body).with_indifferent_access
      parsed_body[:formUrl]
    end

    private

    attr_reader :order

    def register_params
      Sber::GenerateRegisterParams.new(order:).call
    end
  end
end
