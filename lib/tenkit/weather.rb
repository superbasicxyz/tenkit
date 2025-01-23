require_relative './daily_forecast'
require_relative './hourly_forecast'
require_relative './next_hour_forecast'
require_relative './weather_alert_collection'

module Tenkit
  class Weather
    attr_reader :current_weather,
                :forecast_daily,
                :forecast_hourly,
                :forecast_next_hour,
                :weather_alerts

    def initialize(response)
      parsed_response = JSON.parse(response.body)

      current_weather = parsed_response['currentWeather']
      forecast_daily = parsed_response['forecastDaily']
      forecast_hourly = parsed_response['forecastHourly']
      forecast_next_hour = parsed_response['forecastNextHour']
      weather_alerts = parsed_response['weatherAlerts']

      @current_weather = CurrentWeather.new(current_weather)
      @forecast_daily = DailyForecast.new(forecast_daily)
      @forecast_hourly = HourlyForecast.new(forecast_hourly)
      @forecast_next_hour = NextHourForecast.new(forecast_next_hour)
      @weather_alerts = WeatherAlertCollection.new(weather_alerts)
    end
  end
end
