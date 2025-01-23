module Tenkit
  class Conditions
    def initialize(conditions)
      return if conditions.nil?

      conditions.each do |key, val|
        name = key.gsub(/(.)([A-Z])/, '\1_\2').downcase # underscore
        singleton_class.class_eval { attr_accessor name }
        if val.is_a?(Hash)
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

  class CurrentWeather < Conditions; end

  class HourWeatherConditions < Conditions; end

  class DayWeatherConditions < Conditions; end

  class Metadata < Conditions; end

  class DaytimeForecast < Conditions; end

  class OvernightForecast < Conditions; end

  class RestOfDayForecast < Conditions; end
end
