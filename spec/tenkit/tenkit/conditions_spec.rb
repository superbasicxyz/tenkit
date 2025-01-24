require_relative "../spec_helper"
RSpec.describe Tenkit::Conditions do
  let(:payload) { {"topKey" => {"midKey" => {"subKey" => "val"}}} }

  subject { Tenkit::Conditions.new payload }

  describe ".new" do
    it "creates an object with converted attributes" do
      expect(subject.top_key).to be_a Tenkit::Conditions
      expect(subject.top_key.mid_key).to be_a Tenkit::Conditions
      expect(subject.top_key.mid_key.sub_key).to eq "val"
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
