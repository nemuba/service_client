# frozen_string_literal: true

require 'httparty'
require_relative 'response'

module ServiceClient
  # Base class
  class Base
    # ParamsRequired error
    class ParamsRequired < StandardError; end

    class << self
      def post(url = nil, headers: nil, body: nil)
        raise_params_required(url: url, headers: headers, body: body)

        request = HTTParty.post(url, headers: headers, body: body)

        make_response(request)
      end

      def get(url = nil, headers: nil)
        raise_params_required(url: url)

        request = HTTParty.get(url, headers: headers)

        make_response(request)
      end

      def put(url = nil, headers: nil, body: nil)
        raise_params_required(url: url, body: body)

        request = HTTParty.put(url, headers: headers, body: body)

        make_response(request)
      end

      def delete(url = nil, headers: nil)
        raise_params_required(url: url)

        request = HTTParty.delete(url, headers: headers)

        make_response(request)
      end

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
