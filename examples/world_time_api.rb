# frozen_string_literal: true

require './lib/service_client/base'

# WorldTimeApi class
class WorldTimeApi < ServiceClient::Base
  base_url 'https://world-time-api3.p.rapidapi.com'
  default_headers content_type: 'application/json',
                  "x-rapidapi-host": "world-time-api3.p.rapidapi.com",
                  "x-rapidapi-key": ENV["WORLD_TIME_API_KEY"]

  class << self
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
