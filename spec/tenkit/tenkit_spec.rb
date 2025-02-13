require_relative "spec_helper"

RSpec.describe Tenkit do
  let(:api_url) { "https://weatherkit.apple.com/api/v1" }
  let(:data_sets) { Tenkit::Client::DATA_SETS }
  let(:tid) { ENV.fetch("TID", "9876543210") }
  let(:body) { "{}" }

  before { Tenkit.config.team_id = tid }

  context "when improperly configured" do
    let(:tid) { nil }

    describe "#initialize" do
      it "raises a TenkitError" do
        expect { Tenkit::Client.new }.to raise_error Tenkit::TenkitError
      end
    end
  end

  context "when properly configured" do
    let(:headers) { {Accept: "*/*", "Accept-Encoding": /gzip/, Authorization: /Bearer/, "User-Agent": "Ruby"} }
    let(:client) { Tenkit::Client.new }
    let(:lat) { 37.323 }
    let(:lon) { 122.032 }

    before do
      allow(client).to receive(:token) # Github build environment may have invalid ENV['AUTH_KEY']
      stub_request(:get, url).with(headers: headers).to_return(status: 200, body: body, headers: {})
    end

    describe "#availability" do
      let(:url) { "#{api_url}/availability/#{lat}/#{lon}?country=US" }
      let(:body) { data_sets.values.to_json }

      subject { client.availability(lat, lon).body }

      it "returns data sets available for specified location" do
        expect(subject).to eq(data_sets.values.to_s.delete(" "))
      end
    end

    describe "#weather" do
      let(:url) { "#{api_url}/weather/en/#{lat}/#{lon}?dataSets=#{data_sets.values.join(",")}" }

      subject { client.weather(lat, lon, data_sets: data_sets.keys.map(&:to_sym)) }

      it "contains expected base objects" do
        expect(subject).to be_a(Tenkit::WeatherResponse)
        expect(subject.raw).to be_a(HTTParty::Response)
        expect(subject.weather).to be_a(Tenkit::Weather)
        expect(subject.weather.current_weather).to be_a(Tenkit::CurrentWeather)
        expect(subject.weather.forecast_daily).to be_a(Tenkit::DailyForecast)
        expect(subject.weather.forecast_hourly).to be_a(Tenkit::HourlyForecast)
        expect(subject.weather.forecast_next_hour).to be_a(Tenkit::NextHourForecast)
        expect(subject.weather.weather_alerts).to be_a(Tenkit::WeatherAlertCollection)
      end

      context "with CurrentWeather payload" do
        let(:body) { File.read("test/fixtures/currentWeather.json") }

        it "contains CurrentWeather payload objects" do
          expect(subject.weather.current_weather.name).to eq "CurrentWeather"
          expect(subject.weather.current_weather.metadata).to be_a(Tenkit::Metadata)
        end
      end

      context "with DailyForecast payload" do
        let(:body) { File.read("test/fixtures/forecastDaily.json") }

        it "contains DailyForecast payload objects" do
          expect(subject.weather.forecast_daily.name).to eq "DailyForecast"
          expect(subject.weather.forecast_daily.metadata).to be_a(Tenkit::Metadata)
          expect(subject.weather.forecast_daily.days.first).to be_a(Tenkit::DayWeatherConditions)
        end
      end

      context "with HourlyForecast payload" do
        let(:body) { File.read("test/fixtures/forecastHourly.json") }

        it "contains HourlyForecast payload objects" do
          expect(subject.weather.forecast_hourly.name).to eq "HourlyForecast"
          expect(subject.weather.forecast_hourly.metadata).to be_a(Tenkit::Metadata)
          expect(subject.weather.forecast_hourly.hours.first).to be_a(Tenkit::HourWeatherConditions)
        end
      end
    end

    describe "#weather_alert" do
      let(:alert_id) { "0828b382-f63c-4139-9f4f-91a05a4c7cdd" }
      let(:url) { "#{api_url}/weatherAlert/en/#{alert_id}" }

      subject { client.weather_alert(alert_id) }

      it "contains expected base objects" do
        expect(subject).to be_a(Tenkit::WeatherAlertResponse)
        expect(subject.raw).to be_a(HTTParty::Response)
        expect(subject.weather_alert).to be_a(Tenkit::WeatherAlert)
        expect(subject.weather_alert.summary).to be_a(Tenkit::WeatherAlertSummary)
      end

      context "with WeatherAlert payload" do
        let(:body) { File.read("test/fixtures/alert.json") }

        it "contains expected payload objects" do
          expect(subject.weather_alert.summary.name).to eq "WeatherAlert"
          expect(subject.weather_alert.summary.messages.first).to be_a Tenkit::Message
          expect(subject.weather_alert.summary.area).to be_a Tenkit::Area
          expect(subject.weather_alert.summary.area.features.first).to be_a Tenkit::Feature
          expect(subject.weather_alert.summary.area.features.first.geometry).to be_a Tenkit::Geometry
        end
      end
    end
  end
end
