require_relative "../spec_helper"
RSpec.describe Tenkit::Container do
  let(:node) { {"someKey" => "someValue"} }

  subject { Tenkit::Container.new payload }

  describe ".new" do
    context "passed a hash" do
      let(:payload) { {"rootHash" => {"someArray" => [node, node], "someHash" => node}} }

      it "returns an object with converted attributes" do
        expect(subject.root_hash).to be_a Tenkit::Container
        expect(subject.instance_variables).to match [:@root_hash]
        expect(subject.root_hash.some_array.first).to be_a Tenkit::Container
        expect(subject.root_hash.some_array.first.some_key).to eq "someValue"
        expect(subject.root_hash.some_hash).to be_a Tenkit::Container
        expect(subject.root_hash.some_hash.some_key).to eq "someValue"
      end
    end

    context "passed an array" do
      let(:payload) { [node, node] }

      it "returns an empty object" do
        expect(subject).to be_a Tenkit::Container
        expect(subject.instance_variables).to match []
      end
    end

    context "passed an nothing" do
      let(:payload) { nil }

      it "returns an empty object" do
        expect(subject).to be_a Tenkit::Container
        expect(subject.instance_variables).to match []
      end
    end
  end
end
