require_relative "utils"

module Tenkit
  class Conditions
    def initialize(conditions)
      return if conditions.nil? || !conditions.is_a?(Hash)

      conditions.each do |key, val|
        name = Tenkit::Utils.snake(key)
        singleton_class.class_eval { attr_accessor name }
        if val.is_a?(Array)
          val = if key == "days"
            val.map { |e| DayWeatherConditions.new(e) }
          elsif key == "hours"
            val.map { |e| HourWeatherConditions.new(e) }
          else
            val.map { |e| Conditions.new(e) }
          end
        elsif val.is_a?(Hash)
          val = if key == "metadata"
            Metadata.new(val)
          elsif key == "daytimeForecast"
            DaytimeForecast.new(val)
          elsif key == "overnightForecast"
            OvernightForecast.new(val)
          elsif key == "restOfDayForecast"
            RestOfDayForecast.new(val)
          else
            Conditions.new(val)
          end
        end
        instance_variable_set(:"@#{name}", val)
      end
    end
  end

  CurrentWeather = Conditions
  HourlyForecast = Conditions
  DailyForecast = Conditions
  HourWeatherConditions = Conditions
  DayWeatherConditions = Conditions
  Metadata = Conditions
  DaytimeForecast = Conditions
  OvernightForecast = Conditions
  RestOfDayForecast = Conditions
end
