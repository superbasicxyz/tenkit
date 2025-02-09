module TenkitMocks
  module Availability
    def self.all_data_sets
      '["currentWeather","forecastDaily","forecastHourly","forecastNextHour","trendComparison","weatherAlerts"]'
    end
  end

  module Weather
    def self.all_data_sets
      data = {}
      # %w[currentWeather forecastDaily forecastHourly].each do |set|
      #   data.merge!(JSON.parse File.read("test/fixtures/#{set}.json"))
      # end
      data.to_json
    end
  end

  module WeatherAlert
    def self.alert
      # File.read("test/fixtures/alert.json")
      {}.to_json
    end
  end
end
