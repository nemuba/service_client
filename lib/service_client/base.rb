# frozen_string_literal: true

require 'httparty'
require_relative 'response'

module ServiceClient
  # This class provides a lightweight and flexible way to make HTTP requests
  # in Ruby projects.
  #
  # This class can be used to make GET, POST, PUT, and DELETE requests to RESTful APIs.
  # It simplifies the HTTP request process with a simple and intuitive API, configurable
  # base URL, and default headers. It also provides a consistent and structured way to
  # receive responses.
  class Base
    class << self
      # Sets the base URL to be used for all requests.
      #
      # @param url [String] the base URL to be used
      def base_url(url = nil)
        @base_url = url
      end

      # Sets the default headers to be sent with all requests.
      #
      # @param headers [Hash] the default headers to be sent
      def default_headers(headers = nil)
        @default_headers = headers
      end

      # Makes a POST request to the specified URL.
      #
      # @param url [String] the URL to make the request to
      # @param headers [Hash] additional headers to send with the request
      # @param body [Hash] the request body to send with the request
      def post(url = nil, headers: nil, body: nil)
        request(:post, url, headers: headers, body: body)
      end

      # Makes a GET request to the specified URL.
      #
      # @param url [String] the URL to make the request to
      # @param headers [Hash] additional headers to send with the request
      def get(url = nil, headers: nil)
        request(:get, url, headers: headers)
      end

      # Makes a PUT request to the specified URL.
      #
      # @param url [String] the URL to make the request to
      # @param headers [Hash] additional headers to send with the request
      # @param body [Hash] the request body to send with the request
      def put(url = nil, headers: nil, body: nil)
        request(:put, url, headers: headers, body: body)
      end

      # Makes a DELETE request to the specified URL.
      #
      # @param url [String] the URL to make the request to
      # @param headers [Hash] additional headers to send with the request
      def delete(url = nil, headers: nil)
        request(:delete, url, headers: headers)
      end

      private

      # Makes an HTTP request to the specified URL.
      #
      # @param method [Symbol] the HTTP method to use (e.g. :get, :post)
      # @param url [String] the URL to make the request to
      # @param headers [Hash] additional headers to send with the request
      # @param body [Hash] the request body to send with the request
      def request(method, url, headers: nil, body: nil)
        raise_params_required(url: url)

        options = {
          headers: build_headers(headers),
          body: body
        }.compact

        request = HTTParty.send(method, build_url(url), options)

        make_response(request)
      end

      # Converts the HTTP response into a structured response object.
      #
      # @param response [HTTParty::Response] the HTTP response object to convert
      # @return [Response] the structured response object
      def make_response(response)
        Response.call(response)
      end

      # Raises an error if any of the required params are nil.
      # 
      # @param params [Hash] the params to check for nil values
      # @raise [ParamsRequired] if any of the params are nil
      # @return [nil] if all params are not nil
      def raise_params_required(params)
        raise ParamsRequired, "Params: #{params_required(params)} are required" if params_nil?(params)
      end

      # Returns an array of the keys of the params that are nil.
      #
      # @param params [Hash] the params to check for nil values
      # @return [Array] the keys of the params that are nil
      def params_required(params)
        params.select { |_, value| value.nil? }.keys
      end

      # Returns true if any of the params are nil.
      #
      # @param params [Hash] the params to check for nil values
      # @return [Boolean] true if any of the params are nil
      def params_nil?(params)
        params.values.any?(&:nil?)
      end

      # Builds the URL to make the request to.
      #
      # @param path [String] the path to append to the base URL
      # @return [String] the URL to make the request
      def build_url(path)
        base_url = instance_variable_get('@base_url')

        return if base_url.nil? && path.nil?

        [base_url, path].compact.join('/')
      end

      # Builds the headers to send with the request.
      #
      # @param headers [Hash] the headers to send with the request
      # @return [Hash] the headers to send with the request
      def build_headers(headers)
        default_headers = instance_variable_get('@default_headers')
        return default_headers if headers.nil?

        return headers if default_headers.nil?

        default_headers.merge(headers)
      end
    end
  end
end
