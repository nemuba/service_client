# frozen_string_literal: true
require_relative 'errors'
# Purpose: Response class for ServiceClient
#
# Compare this snippet from lib/service_client/response.rb:
module ServiceClient
  # Response class
  class Response
    include ServiceClient::Errors

    attr_accessor :code, :data, :headers

    def initialize(response)
      @code = response.code
      @data = response.parsed_response
      @headers = response.headers
    end

    def call
      case code
      when 200..299
        self
      else
        raise_error(code.to_s, self)
      end
    end

    def self.call(response)
      new(response).call
    end
  end
end
