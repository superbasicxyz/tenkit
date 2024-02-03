require_relative './response'

module Tenkit
  class WeatherAlertResponse < Response
    attr_reader :weather_alert
    def initialize(response)
      super
      @weather_alert = Tenkit::WeatherAlert.new(response)
    end
  end
end
