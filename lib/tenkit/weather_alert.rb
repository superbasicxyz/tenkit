require_relative './weather_alert_summary'

module Tenkit
  class WeatherAlert
    attr_reader :summary

    def initialize(response)
      parsed_response = JSON.parse(response.body)
      @summary = WeatherAlertSummary.new(parsed_response)
    end
  end
end
