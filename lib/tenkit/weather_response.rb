require_relative "response"

module Tenkit
  class WeatherResponse < Response
    attr_reader :weather

    def initialize(response)
      super
      @weather = Weather.new(response)
    end
  end
end
