require_relative "../spec_helper"
require "pry"

RSpec.describe Tenkit::WeatherAlert do
  let(:client) { Tenkit::Client.new }
  let(:api_response) { double("WeatherAlertResponse", body: json) }
  let(:json) { File.read("test/fixtures/alert.json") }
  let(:alert_id) { "0828b382-f63c-4139-9f4f-91a05a4c7cdd" }

  before { allow(client).to receive(:get).and_return(api_response) }

  describe "weather_alert" do
    let(:head) { "...HEAT ADVISORY REMAINS IN EFFECT UNTIL 7 PM PDT THIS EVENING..." }
    let(:tail) { "particularly for those working or\nparticipating in outdoor activities." }

    subject { client.weather_alert(alert_id).weather_alert.summary }

    it "includes expected message" do
      expect(subject.messages.first.text).to start_with head
      expect(subject.messages.first.text).to end_with tail
    end

    it "includes expected summary data" do
      expect(subject.area_id).to eq "caz017"
      expect(subject.area_name).to eq "Southern Sacramento Valley"
      expect(subject.certainty).to eq "likely"
      expect(subject.country_code).to eq "US"
      expect(subject.description).to eq "Heat Advisory"
      expect(subject.details_url).to start_with "https://"
      expect(subject.id).to eq "cbff5515-5ed0-518b-ae8b-bcfdd5844d41"
      expect(subject.responses).to be_empty
      expect(subject.severity).to eq "minor"
      expect(subject.source).to eq "National Weather Service"
      expect(subject.urgency).to eq "expected"
      expect(subject.importance).to eq "low"
      expect(subject.effective_time).to eq "2022-08-20T08:54:00Z"
      expect(subject.event_end_time).to eq "2022-08-21T02:00:00Z"
      expect(subject.expire_time).to eq "2022-08-21T02:00:00Z"
      expect(subject.issued_time).to eq "2022-08-20T08:54:00Z"
    end
  end
end
