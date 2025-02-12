require_relative "utils"

module Tenkit
  class Container
    def initialize(contents)
      return unless contents.is_a?(Hash)

      contents.each do |key, val|
        name = Tenkit::Utils.snake(key)
        singleton_class.class_eval { attr_accessor name }
        if val.is_a?(Array)
          val = if key == "days"
            val.map { |e| DayWeatherConditions.new(e) }
          elsif key == "hours"
            val.map { |e| HourWeatherConditions.new(e) }
          elsif key == "features"
            val.map { |e| Feature.new(e) }
          elsif key == "messages"
            val.map { |e| Message.new(e) }
          elsif key == "coordinates"
            Coordinates.new(val)
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
          elsif key == "area"
            Area.new(val)
          elsif key == "geometry"
            Geometry.new(val)
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

  class Feature < Container; end

  class Message < Container; end

  class Coordinates < Array; end

  class DayWeatherConditions < Container; end

  class Metadata < Container; end

  class DaytimeForecast < Container; end

  class OvernightForecast < Container; end

  class RestOfDayForecast < Container; end

  class Area < Container; end

  class Geometry < Container; end
end
