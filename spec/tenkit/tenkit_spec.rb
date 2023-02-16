require 'tenkit'
require 'dotenv'
Dotenv.load

RSpec.describe Tenkit do
  describe '#availability' do
    it 'returns the data sets available for specified location' do
      tenkit_config = {
        team_id: ENV['TID'],
        service_id: ENV['SID'],
        key_id: ENV['KID'],
        key: ENV['AUTH_KEY']
      }
      client = Tenkit::Client.new(tenkit_config)
      expect(client.availability('37.323', '122.032').body).to eq('["currentWeather","forecastDaily","forecastHourly","trendComparison","weatherAlerts"]')
    end
  end

  describe '#weather' do
    it 'returns weather data for the specified location' do
      tenkit_config = {
        team_id: ENV['TID'],
        service_id: ENV['SID'],
        key_id: ENV['KID'],
        key: ENV['AUTH_KEY']
      }
      client = Tenkit::Client.new(tenkit_config)
      expect(client.weather('37.323', '122.032').code).to eq(200)
    end
  end
end
