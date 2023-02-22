# frozen_string_literal: true

require 'httparty'
require_relative 'response'

module ServiceClient
  # ParamsRequired error
  class ParamsRequired < StandardError; end

  # Base class
  class Base
    class << self
      def base_url(url = nil)
        @base_url = url
      end

      def default_headers(headers = nil)
        @default_headers = headers
      end

      def post(url = nil, headers: nil, body: nil)
        raise_params_required(url: url, headers: headers, body: body)

        request = HTTParty.post(build_url(url), headers: build_headers(headers), body: body)

        make_response(request)
      end

      def get(url = nil, headers: nil)
        raise_params_required(url: url)

        request = HTTParty.get(build_url(url), headers: build_headers(headers))

        make_response(request)
      end

      def put(url = nil, headers: nil, body: nil)
        raise_params_required(url: url, body: body)

        request = HTTParty.put(build_url(url), headers: build_headers(headers), body: body)

        make_response(request)
      end

      def delete(url = nil, headers: nil)
        raise_params_required(url: url)

        request = HTTParty.delete(build_url(url), headers: build_headers(headers))

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

      def build_url(path)
        base_url = instance_variable_get('@base_url')

        return if base_url.nil? && path.nil?

        [base_url, path].compact.join('/')
      end

      def build_headers(headers)
        default_headers = instance_variable_get('@default_headers')
        return default_headers if headers.nil?

        return headers if default_headers.nil?

        default_headers.merge(headers)
      end
    end
  end
end
