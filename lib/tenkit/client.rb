# frozen_string_literal: true

require 'httparty'
require_relative './weather_response'

module Tenkit
  class Client
    include HTTParty
    base_uri 'https://weatherkit.apple.com/api/v1'

    attr_reader :user_token

    DATA_SETS = {
      current_weather: 'currentWeather',
      forecast_daily: 'forecastDaily',
      forecast_hourly: 'forecastHourly',
      forecast_next_hour: 'forecastNextHour',
      trend_comparison: 'trendComparison',
      weather_alerts: 'weatherAlerts'
    }.freeze

    def initialize(user_token: nil)
      Tenkit.config.validate!

      @user_token = user_token
    end

    def availability(lat, lon, country: 'US')
      get("/availability/#{lat}/#{lon}?country=#{country}")
    end

    def weather(lat, lon, data_sets: [:current_weather], language: 'en')
      path_root = "/weather/#{language}/#{lat}/#{lon}?dataSets="
      path = path_root + data_sets.map { |ds| DATA_SETS[ds] }.compact.join(',')
      response = get(path)
      WeatherResponse.new(response)
    end

    def weather_alert(id, language: 'en')
      puts 'TODO: implement weather alert endpoint'
      puts language
      puts id
    end

    private

    def get(url)
      headers = { Authorization: "Bearer #{token}" }
      self.class.get(url, { headers: headers })
    end

    def token
      user_token || Authentication.new_token
    end
  end
end
