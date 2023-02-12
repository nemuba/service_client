# frozen_string_literal: true
require_relative 'service_client/version'
require_relative 'service_client/response'
require_relative 'service_client/errors'
require 'httparty'
require 'rack/utils'

# Service Client
module ServiceClient
  # ParamsRequired error
  class ParamsRequired < StandardError; end

  # Call class
  class Call
    def self.post(url = nil, headers: nil, body: nil)
      raise_params_required(url: url, headers: headers, body: body)

      request = HTTParty.post(url, headers: headers, body: body)

      make_response(request)
    end

    def self.get(url = nil, headers: nil)
      raise_params_required(url: url)

      request = HTTParty.get(url, headers: headers)

      make_response(request)
    end

    def self.put(url = nil, headers: nil, body: nil)
      raise_params_required(url: url, body: body)

      request = HTTParty.put(url, headers: headers, body: body)

      make_response(request)
    end

    def self.delete(url = nil, headers: nil)
      raise_params_required(url: url)

      request = HTTParty.delete(url, headers: headers)

      make_response(request)
    end

    class << self
      private

      def make_response(response)
        Response.call(response)
      end

      def raise_params_required(params)
        raise ParamsRequired, "Params: #{nil_params(params)} are required" if params_nil?(params)
      end

      def nil_params(params)
        params.select { |_, value| value.nil? }.keys
      end

      def params_nil?(params)
        params.values.any?(&:nil?)
      end
    end
  end
end
