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
      expect(client.weather('37.323', '122.032')).to be_a(Tenkit::Weather)
    end
  end
end
