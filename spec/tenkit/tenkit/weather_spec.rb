require_relative "../spec_helper"

RSpec.describe Tenkit::Weather do
  let(:lat) { 37.32 }
  let(:lon) { 122.03 }
  let(:client) { Tenkit::Client.new }
  let(:api_response) { double("WeatherResponse", body: json) }
  let(:json) { File.read("test/fixtures/#{data_set}.json") }

  before { allow(client).to receive(:get).and_return(api_response) }

  subject { client.weather(lat, lon) }

  describe "currentWeather" do
    let(:data_set) { "currentWeather" }
    it "returns current weather data" do
      cw = subject.weather.current_weather
      expect(cw.metadata.latitude).to be 37.32
      expect(cw.metadata.longitude).to be 122.03
      expect(cw.temperature).to be(-5.68)
      expect(cw.temperature_apparent).to be(-6.88)
    end
  end

  describe "forecastDaily" do
    let(:data_set) { "forecastDaily" }

    it "returns 10 days of data" do
      days = subject.weather.forecast_daily.days
      expect(days.size).to be 10
    end

    it "returns daily forecast data" do
      first_day = subject.weather.forecast_daily.days.first
      expect(first_day.condition_code).to eq "Clear"
      expect(first_day.max_uv_index).to be 2
      expect(first_day.temperature_max).to be 6.34
      expect(first_day.temperature_min).to be(-6.35)
    end

    it "returns daytime and overnight forecast data" do
      first_day = subject.weather.forecast_daily.days.first
      expect(first_day.daytime_forecast.condition_code).to eq "Clear"
      expect(first_day.daytime_forecast.temperature_max).to be 6.34
      expect(first_day.overnight_forecast.condition_code).to eq "Clear"
      expect(first_day.overnight_forecast.temperature_max).to be(-0.28)
    end
  end

  describe "forecastHourly" do
    let(:data_set) { "forecastHourly" }

    it "returns 25 hours of data" do
      days = subject.weather.forecast_hourly.hours
      expect(days.size).to be 25
    end

    it "returns hourly forecast data" do
      first_hour = subject.weather.forecast_hourly.hours.first
      expect(first_hour.condition_code).to eq "MostlyClear"
      expect(first_hour.temperature).to be(-5.86)
    end
  end
end
