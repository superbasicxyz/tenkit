require_relative "utils"

module Tenkit
  class Container
    def initialize(contents)
      return if contents.nil? || !contents.is_a?(Hash)

      contents.each do |key, val|
        name = Tenkit::Utils.snake(key)
        singleton_class.class_eval { attr_accessor name }
        if val.is_a?(Array)
          val = if key == "days"
            val.map { |e| DayWeatherConditions.new(e) }
          elsif key == "hours"
            val.map { |e| HourWeatherConditions.new(e) }
          else
            val.map { |e| Container.new(e) }
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
            Container.new(val)
          end
        end
        instance_variable_set(:"@#{name}", val)
      end
    end
  end

  CurrentWeather = Container
  HourlyForecast = Container
  DailyForecast = Container
  HourWeatherConditions = Container
  DayWeatherConditions = Container
  Metadata = Container
  DaytimeForecast = Container
  OvernightForecast = Container
  RestOfDayForecast = Container
end
