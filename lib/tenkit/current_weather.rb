module Tenkit
  class CurrentWeather
    attr_reader :as_of,
                :cloud_cover,
                :condition_code,
                :daylight,
                :humidity,
                :precipitation_intensity,
                :pressure,
                :pressure_trend,
                :temperature,
                :temperature_apparent,
                :temperature_dew_point,
                :uv_index,
                :visibility,
                :wind_direction,
                :wind_gust,
                :wind_speed

    def initialize(current_weather)
      @as_of = current_weather['asOf']
      @cloud_cover = current_weather['cloudCover']
      @condition_code = current_weather['conditionCode']
      @daylight = current_weather['daylight']
      @humidity = current_weather['humidity']
      @precipitation_intensity = current_weather['precipitationIntensity']
      @pressure = current_weather['pressure']
      @pressure_trend = current_weather['pressureTrend']
      @temperature = current_weather['temperature']
      @temperature_apparent = current_weather['temperatureApparent']
      @temperature_dew_point = current_weather['temperatureDewPoint']
      @uv_index = current_weather['uvIndex']
      @visibility = current_weather['visibility']
      @wind_direction = current_weather['windDirection']
      @wind_gust = current_weather['windGust']
      @wind_speed = current_weather['windSpeed']
    end
  end
end
