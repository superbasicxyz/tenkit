# frozen_string_literal: true

require 'jwt'
require 'openssl'

module Tenkit
  class Client
    def initialize(config)
      @team_id = config[:team_id]
      @service_id = config[:service_id]
      @key_id = config[:key_id]
      @key = config[:key]
    end

    def get_weather
      token
    end

    private

    def token
      header = {
        alg: 'ES256',
        kid: @key_id,
        id: "#{@team_id}.#{@service_id}"
      }

      payload = {
        iss: @team_id,
        iat: Time.new.to_i,
        exp: Time.new.to_i + 5,
        sub: @service_id
      }

      key = OpenSSL::PKey::EC.new @key

      JWT.encode payload, key, 'ES256', header
    end
  end
end
