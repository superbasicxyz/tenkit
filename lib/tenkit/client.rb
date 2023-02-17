# frozen_string_literal: true

require 'jwt'
require 'openssl'
require 'httparty'

module Tenkit
  class Client
    include HTTParty
    base_uri 'https://weatherkit.apple.com/api/v1'

    def availability(lat, lon, country = 'US')
      get("/availability/#{lat}/#{lon}?country=#{country}")
    end

    def weather(lat, lon, language = 'en')
      get("/weather/#{language}/#{lat}/#{lon}?dataSets=currentWeather")
    end

    private

    def get(url)
      puts token
      headers = { Authorization: "Bearer #{token}" }
      self.class.get(url, { headers: headers })
    end

    def header
      {
        alg: 'ES256',
        kid: Tenkit.config.key_id,
        id: "#{Tenkit.config.team_id}.#{Tenkit.config.service_id}"
      }
    end

    def payload
      {
        iss: Tenkit.config.team_id,
        iat: Time.new.to_i,
        exp: Time.new.to_i + 600,
        sub: Tenkit.config.service_id
      }
    end

    def key
      OpenSSL::PKey.read Tenkit.config.key
    end

    def token
      JWT.encode payload, key, 'ES256', header
    end
  end
end
