require_relative "../spec_helper"
RSpec.describe Tenkit::Conditions do
  let(:sample) { {"Key" => "val"} }

  subject { Tenkit::Conditions.new payload }

  describe ".new" do
    context "passed a hash" do
      let(:payload) { {"rootHash" => {"someArray" => [sample], "someHash" => sample}} }

      it "creates an object with converted attributes" do
        expect(subject.root_hash).to be_a Tenkit::Conditions
        expect(subject.instance_variables).to match [:@root_hash]
        expect(subject.root_hash.some_array.first).to be_a Tenkit::Conditions
        expect(subject.root_hash.some_array.first.key).to eq "val"
        expect(subject.root_hash.some_hash).to be_a Tenkit::Conditions
        expect(subject.root_hash.some_hash.key).to eq "val"
      end
    end

    context "passed an array" do
      let(:payload) { [sample, sample] }

      it "creates returns an empty object" do
        expect(subject).to be_a Tenkit::Conditions
        expect(subject.instance_variables).to match []
      end
    end
  end
end
