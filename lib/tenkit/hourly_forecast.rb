module Tenkit
  class HourlyForecast
    attr_reader :hours

    def initialize(hourly_forecast)
      return if hourly_forecast.nil?

      @hours = hourly_forecast['hours']
    end
  end
end
