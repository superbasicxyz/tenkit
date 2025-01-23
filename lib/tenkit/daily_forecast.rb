module Tenkit
  class DailyForecast
    attr_reader :days, :learn_more_url

    def initialize(daily_forecast)
      return if daily_forecast.nil?

      @days = daily_forecast['days'].map { |day| DayWeatherConditions.new(day) }
      @learn_more_url = daily_forecast['learnMoreURL']
    end
  end
end
