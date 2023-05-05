module Tenkit
  class WeatherAlert
    def initialize(response)
      parsed_response = JSON.parse(response.body)
    end
  end
end
