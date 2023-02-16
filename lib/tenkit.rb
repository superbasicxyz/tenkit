# frozen_string_literal: true

require 'jwt'
require 'openssl'
require 'httparty'

module Tenkit
  class Client
    include HTTParty
    base_uri 'https://weatherkit.apple.com/api/v1'

    def initialize(config)
      puts config
      @team_id = config[:team_id]
      @service_id = config[:service_id]
      @key_id = config[:key_id]
      @key = config[:key]
    end

    def availability(lat, lon, country = 'US')
      get("/availability/#{lat}/#{lon}?country=#{country}")
    end

    def weather(lat, lon, language = 'en')
      get("/weather/#{language}/#{lat}/#{lon}?dataSets=currentWeather")
    end

    private

    def get(url)
      headers = { Authorization: "Bearer #{token}" }
      self.class.get(url, { headers: headers })
    end

    def header
      {
        alg: 'ES256',
        kid: @key_id,
        id: "#{@team_id}.#{@service_id}"
      }
    end

    def payload
      {
        iss: @team_id,
        iat: Time.new.to_i,
        exp: Time.new.to_i + 600,
        sub: @service_id
      }
    end

    def key
      OpenSSL::PKey.read @key
    end

    def token
      JWT.encode payload, key, 'ES256', header
    end
  end
end
