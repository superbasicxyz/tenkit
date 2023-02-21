module Tenkit
  class DayWeatherConditions
    attr_reader :condition_code,
                :daytime_forecast,
                :forecast_end,
                :forecast_start,
                :max_uv_index,
                :moon_phase,
                :moonrise,
                :moonset,
                :overnight_forecast,
                :precipitation_amount,
                :precipitation_chance,
                :precipitation_type,
                :snowfall_amount,
                :solar_midnight,
                :solar_noon,
                :sunrise,
                :sunrise_astronomical,
                :sunrise_civil,
                :sunrise_nautical,
                :sunset,
                :sunset_astronomical,
                :sunset_civil,
                :sunset_nautical,
                :temperature_max,
                :temperature_min

    def initialize(day_weather_conditions)
      @condition_code = day_weather_conditions['condition_code']
      @daytime_forecast = day_weather_conditions['daytime_forecast']
      @forecast_end = day_weather_conditions['forecast_end']
      @forecast_start = day_weather_conditions['forecast_start']
      @max_uv_index = day_weather_conditions['max_uv_index']
      @moon_phase = day_weather_conditions['moon_phase']
      @moonrise = day_weather_conditions['moonrise']
      @moonset = day_weather_conditions['moonset']
      @overnight_forecast = day_weather_conditions['overnight_forecast']
      @precipitation_amount = day_weather_conditions['precipitation_amount']
      @precipitation_chance = day_weather_conditions['precipitation_chance']
      @precipitation_type = day_weather_conditions['precipitation_type']
      @snowfall_amount = day_weather_conditions['snowfall_amount']
      @solar_midnight = day_weather_conditions['solar_midnight']
      @solar_noon = day_weather_conditions['solar_noon']
      @sunrise = day_weather_conditions['sunrise']
      @sunrise_astronomical = day_weather_conditions['sunrise_astronomical']
      @sunrise_civil = day_weather_conditions['sunrise_civil']
      @sunrise_nautical = day_weather_conditions['sunrise_nautical']
      @sunset = day_weather_conditions['sunset']
      @sunset_astronomical = day_weather_conditions['sunset_astronomical']
      @sunset_civil = day_weather_conditions['sunset_civil']
      @sunset_nautical = day_weather_conditions['sunset_nautical']
      @temperature_max = day_weather_conditions['temperature_max']
      @temperature_min = day_weather_conditions['temperature_min']
    end
  end

  class DailyForecast
    attr_reader :days, :learn_more_url

    def initialize(daily_forecast)
      @days = daily_forecast['days']
      @learn_more_url = daily_forecast['learnMoreURL']
    end
  end

  class HourlyForecast
    attr_reader :hours

    def initialize(hourly_forecast)
      @hours = hourly_forecast['hours']
    end
  end

  class TrendComparison; end
  class WeatherAlertCollection; end

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

  class Weather
    attr_reader :current_weather,
                :forecast_daily,
                :forecast_hourly,
                :forecast_next_hour,
                :weather_alerts

    def initialize(current_weather, forecast_daily, forecast_hourly, forecast_next_hour, weather_alerts)
      @current_weather = CurrentWeather.new(current_weather)
      @forecast_daily = DailyForecast.new(forecast_daily)
      @forecast_hourly = HourlyForecast.new(forecast_hourly)
      @forecast_next_hour = NextHourForecast.new(forecast_next_hour)
      @weather_alerts = WeatherAlertCollection.new(weather_alerts)
    end
  end
end
