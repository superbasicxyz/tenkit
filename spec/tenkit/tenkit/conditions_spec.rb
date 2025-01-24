require_relative "../spec_helper"
RSpec.describe Tenkit::Conditions do
  let(:sample) { {"Key" => "val"} }
  let(:payload) { {"main" => {"someArray" => [sample], "someHash" => sample}} }

  subject { Tenkit::Conditions.new payload }

  describe ".new" do
    it "creates an object with converted attributes" do
      expect(subject.main).to be_a Tenkit::Conditions
      expect(subject.main.some_array.first).to be_a Tenkit::Conditions
      expect(subject.main.some_array.first.key).to eq "val"
      expect(subject.main.some_hash).to be_a Tenkit::Conditions
      expect(subject.main.some_hash.key).to eq "val"
    end
  end

  describe "#snake" do
    let(:simple) { "someCamelCaseString" }
    let(:correct) { "some_camel_case_string" }
    let(:complex) { "someAWSCredentials" }
    let(:mangled) { "some_aw_scredentials" }

    it "converst to snake case" do
      expect(subject.snake(simple)).to eq correct
    end

    context "when passed an acronym" do
      it "does a poor job" do
        expect(subject.snake(complex)).to eq mangled
      end
    end

    # require 'fast_underscore'
    context "when a proper underscore package is available" do
      let(:patched_string) { PatchedString.new complex }
      before {
        class PatchedString < String
          def underscore
            :correct
          end; end
      }

      it "uses string underscore method" do
        expect(subject.snake(patched_string)).to eq :correct
      end
    end
  end
end
