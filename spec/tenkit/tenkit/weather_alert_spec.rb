require_relative "../spec_helper"

RSpec.describe Tenkit::WeatherAlert do
  let(:client) { Tenkit::Client.new }
  let(:api_response) { double("WeatherAlertResponse", body: json) }
  let(:json) { File.read("test/fixtures/alert.json") }
  let(:alert_id) { "0828b382-f63c-4139-9f4f-91a05a4c7cdd" }

  before { allow(client).to receive(:get).and_return(api_response) }

  describe "weather_alert" do
    let(:msg_head) { "...HEAT ADVISORY REMAINS IN EFFECT UNTIL 7 PM PDT THIS EVENING..." }
    let(:msg_tail) { "for those working or\nparticipating in outdoor activities." }

    subject { client.weather_alert(alert_id).weather_alert.summary }

    it "includes expected message" do
      expect(subject.messages.first).to be_a Tenkit::Message
      expect(subject.messages.first.text).to start_with msg_head
      expect(subject.messages.first.text).to end_with msg_tail
    end

    it "includes expected area" do
      expect(subject.area).to be_a Tenkit::Area
      expect(subject.area.features.first).to be_a Tenkit::Feature
      expect(subject.area.features.first.geometry).to be_a Tenkit::Geometry
      expect(subject.area.features.first.geometry.type).to eq "Polygon"
      expect(subject.area.features.first.geometry.coordinates).to be_a Tenkit::Coordinates
      expect(subject.area.features.first.geometry.coordinates.size).to eq 1
      expect(subject.area.features.first.geometry.coordinates.first.size).to eq 177
      expect(subject.area.features.first.geometry.coordinates.first.first).to match [-122.4156, 38.8967]
    end

    it "includes expected summary data" do
      expect(subject.area_id).to eq "caz017"
      expect(subject.area_name).to eq "Southern Sacramento Valley"
      expect(subject.certainty).to eq "likely"
      expect(subject.country_code).to eq "US"
      expect(subject.description).to eq "Heat Advisory"
      expect(subject.details_url).to start_with "https://"
      expect(subject.effective_time).to eq "2022-08-20T08:54:00Z"
      expect(subject.event_end_time).to eq "2022-08-21T02:00:00Z"
      expect(subject.event_source).to eq "US"
      expect(subject.expire_time).to eq "2022-08-21T02:00:00Z"
      expect(subject.id).to eq "cbff5515-5ed0-518b-ae8b-bcfdd5844d41"
      expect(subject.importance).to eq "low"
      expect(subject.issued_time).to eq "2022-08-20T08:54:00Z"
      expect(subject.name).to eq "WeatherAlert"
      expect(subject.precedence).to be 0
      expect(subject.responses).to be_empty
      expect(subject.severity).to eq "minor"
      expect(subject.source).to eq "National Weather Service"
      expect(subject.urgency).to eq "expected"
    end
  end
end
