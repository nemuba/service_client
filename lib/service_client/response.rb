# frozen_string_literal: true

require_relative 'errors'

module ServiceClient
  # The Response class encapsulates the HTTP response received by the ServiceClient gem.
  #
  # @attr_reader [Integer] code The HTTP status code of the response.
  # @attr_reader [Hash, Array, String] data The parsed body of the response.
  # @attr_reader [Hash] headers The HTTP headers of the response.
  class Response
    include ServiceClient::Errors

    attr_reader :code, :data, :headers

    # Initializes a new instance of Response with the given HTTP response object.
    #
    # @param response [HTTParty::Response] The HTTP response object.
    def initialize(response)
      @code = response.code
      @data = response.parsed_response
      @headers = response.headers
    end

    # Determines whether the response was successful or not.
    #
    # @return [ServiceClient::Response] Returns itself if the response was successful.
    # @raise [ServiceClient::Error] Raises an error with the response code and object if the response was unsuccessful.
    def call
      case code
      when 200..299
        self
      else
        raise_error(code.to_s, self)
      end
    end

    class << self
      # Initializes a new instance of Response and calls it to determine success or failure.
      #
      # @param response [HTTParty::Response] The HTTP response object.
      # @return [ServiceClient::Response] Returns itself if the response was successful.
      # @raise [ServiceClient::Error] Raises an error with the response code
      # and object if the response was unsuccessful.
      def call(response)
        new(response).call
      end
    end
  end
end
