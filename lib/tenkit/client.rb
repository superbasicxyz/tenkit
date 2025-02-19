# frozen_string_literal: true

require 'jwt'
require 'openssl'
require 'httparty'
require_relative './weather_response'
require_relative './weather_alert_response'

module Tenkit
  class Client
    include HTTParty
    base_uri 'https://weatherkit.apple.com/api/v1'

    DATA_SETS = {
      current_weather: 'currentWeather',
      forecast_daily: 'forecastDaily',
      forecast_hourly: 'forecastHourly',
      forecast_next_hour: 'forecastNextHour',
      trend_comparison: 'trendComparison',
      weather_alerts: 'weatherAlerts'
    }.freeze

    def initialize
      Tenkit.config.validate!
    end

    def availability(lat, lon, **options)
      options[:country] ||= 'US'

      query = { country: options[:country] }
      get("/availability/#{lat}/#{lon}", query: query)
    end

    def weather(lat, lon, **options)
      options[:data_sets] ||= [:current_weather]
      options[:language] ||= 'en'

      query = weather_query_for_options(options)
      path = "/weather/#{options[:language]}/#{lat}/#{lon}"

      response = get(path, query: query)
      WeatherResponse.new(response)
    end

    def weather_alert(id, language: 'en')
      path = "/weatherAlert/#{language}/#{id}"
      response = get(path)
      WeatherAlertResponse.new(response)
    end

    private

    def get(url, query: nil)
      headers = { Authorization: "Bearer #{token}" }
      params = { headers: headers }
      params[:query] = query unless query.nil?
      self.class.get(url, params)
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

    # Snake case options to expected query parameters
    # https://developer.apple.com/documentation/weatherkitrestapi/get-api-v1-weather-_language_-_latitude_-_longitude_#query-parameters
    def weather_query_for_options(options)
      data_sets_param = options[:data_sets].map { |ds| DATA_SETS[ds] }.compact.join(',')

      {
        countryCode: options[:country_code],
        currentAsOf: options[:current_as_of],
        dailyEnd: options[:daily_end],
        dailyStart: options[:daily_start],
        dataSets: data_sets_param,
        hourlyEnd: options[:hourly_end],
        hourlyStart: options[:hourly_start],
        timezone: options[:timezone]
      }.compact
    end
  end
end
