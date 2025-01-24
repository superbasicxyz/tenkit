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
    let(:cw) { subject.weather.current_weather }
    let(:data_set) { "currentWeather" }

    it "includes expected metadata" do
      expect(cw.name).to eq "CurrentWeather"
      expect(cw.metadata.attribution_url).to start_with 'https://'
      expect(cw.metadata.latitude).to be 37.32
      expect(cw.metadata.longitude).to be 122.03
    end

    it "returns correct object types" do
      expect(cw).to be_a Tenkit::CurrentWeather
      expect(cw.metadata).to be_a Tenkit::Metadata
    end

    it "returns current weather data" do
      expect(cw.temperature).to be(-5.68)
      expect(cw.temperature_apparent).to be(-6.88)
    end
  end

  describe "forecastDaily" do
    let(:data_set) { "forecastDaily" }
    let(:forecast) { subject.weather.forecast_daily }
    let(:first_day) { forecast.days.first }

    it "returns 10 days of data" do
      expect(forecast.days.size).to be 10
    end

    it "returns correct object types" do
      expect(forecast).to be_a Tenkit::DailyForecast
      expect(first_day).to be_a Tenkit::DayWeatherConditions
      expect(first_day.daytime_forecast).to be_a Tenkit::DaytimeForecast
      expect(first_day.overnight_forecast).to be_a Tenkit::OvernightForecast
      expect(first_day.rest_of_day_forecast).to be_a Tenkit::RestOfDayForecast
    end

    it "excludes learn_more_url node" do
      expect(forecast.respond_to? :learn_more_url).to be false
    end

    it "includes expected metadata" do
      expect(forecast.name).to eq "DailyForecast"
      expect(forecast.metadata.attribution_url).to start_with 'https://'
      expect(forecast.metadata.latitude).to be 37.32
      expect(forecast.metadata.longitude).to be 122.03
    end

    it "returns daily forecast data" do
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
    let(:forecast) { subject.weather.forecast_hourly }
    let(:first_hour) { forecast.hours.first }

    it "returns 25 hours of data" do
      expect(forecast.hours.size).to be 25
    end

    it "includes expected metadata" do
      expect(forecast.name).to eq "HourlyForecast"
      expect(forecast.metadata.attribution_url).to start_with 'https://'
      expect(forecast.metadata.latitude).to be 37.32
      expect(forecast.metadata.longitude).to be 122.03
    end

    it "returns correct object types" do
      expect(forecast).to be_a Tenkit::HourlyForecast
      expect(first_hour).to be_a Tenkit::HourWeatherConditions
    end

    it "returns hourly forecast data" do
      expect(first_hour.condition_code).to eq "MostlyClear"
      expect(first_hour.temperature).to be(-5.86)
    end
  end
end
