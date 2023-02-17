require 'tenkit'
require 'dotenv'
Dotenv.load

RSpec.describe Tenkit do
  describe '#availability' do
    it 'returns the data sets available for specified location' do
      Tenkit.configure do |c|
        c.team_id = ENV['TID']
        c.service_id = ENV['SID']
        c.key_id = ENV['KID']
        c.key = ENV['AUTH_KEY']
      end
      client = Tenkit::Client.new
      expect(client.availability('37.323', '122.032').body).to eq('["currentWeather","forecastDaily","forecastHourly","trendComparison","weatherAlerts"]')
    end
  end

  describe '#weather' do
    it 'returns weather data for the specified location' do
      Tenkit.configure do |c|
        c.team_id = ENV['TID']
        c.service_id = ENV['SID']
        c.key_id = ENV['KID']
        c.key = ENV['AUTH_KEY']
      end
      client = Tenkit::Client.new
      expect(client.weather('37.323', '122.032').code).to eq(200)
    end
  end
end
