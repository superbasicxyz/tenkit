module Tenkit
  class WeatherAlertCollection
    attr_reader :alerts, :details_url

    def initialize(weather_alerts)
      return if weather_alerts.nil?

      @alerts = weather_alerts['alerts'].map { |alert| WeatherAlertSummary.new(alert) }
      @details_url = weather_alerts['detailsUrl']
    end
  end
end
