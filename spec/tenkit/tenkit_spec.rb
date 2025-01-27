require_relative './spec_helper'
require_relative './mock/weather'

RSpec.describe Tenkit do
  let(:api_url) { "https://weatherkit.apple.com/api/v1"  }
  let(:data_sets) { Tenkit::Client::DATA_SETS }

  subject { Tenkit::Client.new }

  describe '#initialize' do
    it 'raises a TenkitError if not configured fully' do
      Tenkit.config.team_id = nil
      expect { Tenkit::Client.new }.to raise_error Tenkit::TenkitError
      Tenkit.config.team_id = ENV.fetch('TID')
    end
  end

  describe '#availability' do
    it 'returns the data sets available for specified location' do
      stub_request(:get, "#{api_url}/availability/37.323/122.032?country=US").with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=> /Bearer /,
          'User-Agent'=>'Ruby'
        }).to_return(status: 200, body: TenkitMocks::Availability.all_data_sets, headers: {})
      expect(subject.availability('37.323', '122.032').body).to eq(data_sets.values.to_s.delete(" "))
    end
  end

  describe '#weather' do
    it 'returns weather data for the specified location' do
      stub_request(:get, "#{api_url}/weather/en/37.323/122.032?dataSets=#{data_sets.values.join(",")}").with(
        headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=> /Bearer /,
          'User-Agent'=>'Ruby'
        }).to_return(status: 200, body: TenkitMocks::Weather.all_data_sets, headers: {})

      weather_response = subject.weather('37.323', '122.032', data_sets: data_sets.keys.map(&:to_sym))
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
