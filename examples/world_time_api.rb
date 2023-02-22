# frozen_string_literal: true

require './lib/service_client/base'

# WorldTimeApi class
class WorldTimeApi < ServiceClient::Base
  base_url 'http://worldtimeapi.org/api'
  default_headers content_type: 'application/json'

  class << self
    def timezones
      response = get('timezones')

      response.data
    end

    def get_timezone(timezone)
      response = get("timezone/#{timezone}")

      response.data
    end

    def client_ip(ip = nil)
      response = get("ip#{ip ? "/#{ip}" : ''}")

      response.data
    end
  end
end

