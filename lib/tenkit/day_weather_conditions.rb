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
end
