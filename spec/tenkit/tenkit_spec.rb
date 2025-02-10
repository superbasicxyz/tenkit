require_relative "spec_helper"

RSpec.describe Tenkit do
  let(:api_url) { "https://weatherkit.apple.com/api/v1" }
  let(:data_sets) { Tenkit::Client::DATA_SETS }
  let(:tid) { ENV.fetch("TID") }
  let(:body) { "{}" }

  before { Tenkit.config.team_id = tid }

  subject { Tenkit::Client.new }

  context "when improperly configured" do
    let(:tid) { nil }

    describe "#initialize" do
      it "raises a TenkitError" do
        expect { subject }.to raise_error Tenkit::TenkitError
      end
    end
  end

  context "when properly configured" do
    let(:headers) { {Accept: "*/*", "Accept-Encoding": /gzip/, Authorization: /Bearer/, "User-Agent": "Ruby"} }

    before { stub_request(:get, url).with(headers: headers).to_return(status: 200, body: body, headers: {}) }

    describe "#availability" do
      let(:url) { "#{api_url}/availability/37.323/122.032?country=US" }
      let(:body) { data_sets.values.to_json }

      it "returns data sets available for specified location" do
        expect(subject.availability("37.323", "122.032").body).to eq(data_sets.values.to_s.delete(" "))
      end
    end

    describe "#weather" do
      let(:url) { "#{api_url}/weather/en/37.323/122.032?dataSets=#{data_sets.values.join(",")}" }
      let(:resp) { subject.weather("37.323", "122.032", data_sets: data_sets.keys.map(&:to_sym)) }

      it "contains expected base objects" do
        expect(resp).to be_a(Tenkit::WeatherResponse)
        expect(resp.raw).to be_a(HTTParty::Response)
        expect(resp.weather).to be_a(Tenkit::Weather)
        expect(resp.weather.current_weather).to be_a(Tenkit::CurrentWeather)
        expect(resp.weather.forecast_daily).to be_a(Tenkit::DailyForecast)
        expect(resp.weather.forecast_hourly).to be_a(Tenkit::HourlyForecast)
        expect(resp.weather.forecast_next_hour).to be_a(Tenkit::NextHourForecast)
        expect(resp.weather.weather_alerts).to be_a(Tenkit::WeatherAlertCollection)
      end

      context "with CurrentWeather payload" do
        let(:body) { File.read("test/fixtures/currentWeather.json") }

        it "contains CurrentWeather payload objects" do
          expect(resp.weather.current_weather.name).to eq "CurrentWeather"
          expect(resp.weather.current_weather.metadata).to be_a(Tenkit::Metadata)
        end
      end

      context "with DailyForecast payload" do
        let(:body) { File.read("test/fixtures/forecastDaily.json") }

        it "contains DailyForecast payload objects" do
          expect(resp.weather.forecast_daily.name).to eq "DailyForecast"
          expect(resp.weather.forecast_daily.metadata).to be_a(Tenkit::Metadata)
          expect(resp.weather.forecast_daily.days.first).to be_a(Tenkit::DayWeatherConditions)
        end
      end

      context "with HourlyForecast payload" do
        let(:body) { File.read("test/fixtures/forecastHourly.json") }

        it "contains HourlyForecast payload objects" do
          expect(resp.weather.forecast_hourly.name).to eq "HourlyForecast"
          expect(resp.weather.forecast_hourly.metadata).to be_a(Tenkit::Metadata)
          expect(resp.weather.forecast_hourly.hours.first).to be_a(Tenkit::HourWeatherConditions)
        end
      end
    end

    describe "#weather_alert" do
      let(:alert_id) { "0828b382-f63c-4139-9f4f-91a05a4c7cdd" }
      let(:url) { "https://weatherkit.apple.com/api/v1/weatherAlert/en/#{alert_id}" }
      let(:resp) { subject.weather_alert(alert_id) }

      it "contains expected base objects" do
        expect(resp).to be_a(Tenkit::WeatherAlertResponse)
        expect(resp.raw).to be_a(HTTParty::Response)
        expect(resp.weather_alert).to be_a(Tenkit::WeatherAlert)
        expect(resp.weather_alert.summary).to be_a(Tenkit::WeatherAlertSummary)
      end

      context "with valid payload" do
        let(:body) { File.read("test/fixtures/alert.json") }

        it "contains expected payload objects" do
          expect(resp.weather_alert.summary.name).to eq "WeatherAlert"
          expect(resp.weather_alert.summary.messages.first).to be_a Tenkit::Message
          expect(resp.weather_alert.summary.area).to be_a Tenkit::Area
        end
      end
    end
  end
end
