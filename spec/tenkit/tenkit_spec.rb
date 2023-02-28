require_relative './spec_helper'

RSpec.describe Tenkit do
  describe '#availability' do
    it 'returns the data sets available for specified location' do
      client = Tenkit::Client.new
      expect(client.availability('37.323', '122.032').body).to eq('["currentWeather","forecastDaily","forecastHourly","trendComparison","weatherAlerts"]')
    end
  end

  describe '#weather' do
    it 'returns weather data for the specified location' do
      client = Tenkit::Client.new

      weather_response = client.weather('37.323', '122.032', 'en', [:current_weather, :forecast_daily, :forecast_hourly, :trend_comparison, :weather_alerts])
      expect(weather_response).to be_a(Tenkit::WeatherResponse)
      expect(weather_response.raw).to be_a(HTTParty::Response)
      expect(weather_response.weather).to be_a(Tenkit::Weather)
      expect(weather_response.weather.current_weather).to be_a(Tenkit::CurrentWeather)
      expect(weather_response.weather.forecast_daily).to be_a(Tenkit::DailyForecast)
      expect(weather_response.weather.forecast_hourly).to be_a(Tenkit::HourlyForecast)
      expect(weather_response.weather.forecast_next_hour).to be_a(Tenkit::NextHourForecast)
      expect(weather_response.weather.weather_alerts).to be_a(Tenkit::WeatherAlertCollection)
    end
  end
end
