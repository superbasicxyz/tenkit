require_relative "../spec_helper"
RSpec.describe Tenkit::Conditions do
  let(:sample) { {"Key" => "val"} }
  let(:payload) { {"rootHash" => {"someArray" => [sample], "someHash" => sample}} }

  subject { Tenkit::Conditions.new payload }

  describe ".new" do
    it "creates an object with converted attributes" do
      expect(subject.root_hash).to be_a Tenkit::Conditions
      expect(subject.root_hash.some_array.first).to be_a Tenkit::Conditions
      expect(subject.root_hash.some_array.first.key).to eq "val"
      expect(subject.root_hash.some_hash).to be_a Tenkit::Conditions
      expect(subject.root_hash.some_hash.key).to eq "val"
    end
  end
end
