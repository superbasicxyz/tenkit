require_relative "../spec_helper"

RSpec.describe Tenkit::Weather do
  let(:lat) { 37.32 }
  let(:lon) { 122.03 }
  let(:path) { "/weather/en/#{lat}/#{lon}" }
  let(:data_sets) { [Tenkit::Utils.snake(data_set).to_sym] }
  let(:params) { {dataSets: data_set} }
  let(:query) { {query: params} }
  let(:client) { Tenkit::Client.new }
  let(:api_response) { double("WeatherResponse", body: json) }
  let(:json) { File.read("test/fixtures/#{data_set}.json") }

  before { expect(client).to receive(:get).with(path, query).and_return(api_response) }

  describe "currentWeather" do
    let(:data_set) { "currentWeather" }

    context "with options" do
      let(:fmt) { "%FT%TZ" }
      let(:now) { Time.now }
      let(:options) do
        {country_code: "US",
         current_as_of: now.strftime(fmt),
         daily_end: (now + 12 * 3600).strftime(fmt),
         daily_start: (now - 12 * 3600).strftime(fmt),
         data_sets: data_sets,
         hourly_end: (now + 6 * 3600).strftime(fmt),
         hourly_start: (now - 6 * 3600).strftime(fmt),
         timezone: "PST"}
      end
      let(:params) do
        options.map {|k,v| [Tenkit::Utils.camel(k.to_s).to_sym, (k == :data_sets) ? data_set : v]}.to_h
      end

      subject { client.weather(lat, lon, **options).weather.current_weather }

      it "returns response from correct data_sets" do
        subject
      end

      it "includes expected metadata" do
        expect(subject.name).to eq "CurrentWeather"
        expect(subject.metadata.attribution_url).to start_with "https://"
        expect(subject.metadata.latitude).to be 37.32
        expect(subject.metadata.longitude).to be 122.03
      end

      it "returns correct object types" do
        expect(subject).to be_a Tenkit::CurrentWeather
        expect(subject.metadata).to be_a Tenkit::Metadata
      end

      it "returns current weather data" do
        expect(subject.temperature).to be(-5.68)
        expect(subject.temperature_apparent).to be(-6.88)
      end
    end

    context "without options" do
      subject { client.weather(lat, lon).weather.current_weather }

      it "returns response from default currentWeather data set" do
        expect(subject.name).to eq "CurrentWeather"
      end
    end
  end

  describe "forecastDaily" do
    let(:data_set) { "forecastDaily" }
    let(:first_day) { subject.days.first }

    subject { client.weather(lat, lon, data_sets: data_sets).weather.forecast_daily }

    it "returns 10 days of data from correct data sets" do
      expect(subject.days.size).to be 10
    end

    it "returns correct object types" do
      expect(subject).to be_a Tenkit::DailyForecast
      expect(first_day).to be_a Tenkit::DayWeatherConditions
      expect(first_day.daytime_forecast).to be_a Tenkit::DaytimeForecast
      expect(first_day.overnight_forecast).to be_a Tenkit::OvernightForecast
      expect(first_day.rest_of_day_forecast).to be_a Tenkit::RestOfDayForecast
    end

    it "excludes learn_more_url node" do
      expect(subject.respond_to? :learn_more_url).to be false
    end

    it "includes expected metadata" do
      expect(subject.name).to eq "DailyForecast"
      expect(subject.metadata.attribution_url).to start_with 'https://'
      expect(subject.metadata.latitude).to be 37.32
      expect(subject.metadata.longitude).to be 122.03
    end

    it "returns daily forecast data" do
      expect(first_day.condition_code).to eq "Clear"
      expect(first_day.max_uv_index).to be 2
      expect(first_day.temperature_max).to be 6.34
      expect(first_day.temperature_min).to be(-6.35)
    end

    it "returns daytime and overnight forecast data" do
      expect(first_day.daytime_forecast.condition_code).to eq "Clear"
      expect(first_day.daytime_forecast.temperature_max).to be 6.34
      expect(first_day.overnight_forecast.condition_code).to eq "Clear"
      expect(first_day.overnight_forecast.temperature_max).to be(-0.28)
    end
  end

  describe "forecastHourly" do
    let(:data_set) { "forecastHourly" }
    let(:first_hour) { subject.hours.first }

    subject { client.weather(lat, lon, data_sets: data_sets).weather.forecast_hourly }

    it "returns 25 hours of data from correct data sets" do
      expect(subject.hours.size).to be 25
    end

    it "includes expected metadata" do
      expect(subject.name).to eq "HourlyForecast"
      expect(subject.metadata.attribution_url).to start_with 'https://'
      expect(subject.metadata.latitude).to be 37.32
      expect(subject.metadata.longitude).to be 122.03
    end

    it "returns correct object types" do
      expect(subject).to be_a Tenkit::HourlyForecast
      expect(first_hour).to be_a Tenkit::HourWeatherConditions
    end

    it "returns hourly forecast data" do
      expect(first_hour.condition_code).to eq "MostlyClear"
      expect(first_hour.temperature).to be(-5.86)
    end
  end
end
