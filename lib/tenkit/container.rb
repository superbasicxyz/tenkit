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

  class CurrentWeather < Container; end

  class HourlyForecast < Container; end

  class DailyForecast < Container; end

  class WeatherAlertSummary < Container; end

  class HourWeatherConditions < Container; end

  class DayWeatherConditions < Container; end

  class Metadata < Container; end

  class DaytimeForecast < Container; end

  class OvernightForecast < Container; end

  class RestOfDayForecast < Container; end
end
