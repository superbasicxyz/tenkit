require_relative "../spec_helper"
RSpec.describe Tenkit::Utils do
  subject { Tenkit::Utils }

  describe ".snake" do
    let(:simple) { "someCamelCaseString" }
    let(:correct) { "some_camel_case_string" }
    let(:complex) { "someAWSCredentials" }
    let(:mangled) { "some_aw_scredentials" }

    it "converts to snake case" do
      expect(subject.snake(simple)).to eq correct
    end

    context "when passed an acronym" do
      it "does a mediocre job converting string" do
        expect(subject.snake(complex)).to eq mangled
      end
    end

    context "when a proper underscore package is available" do
      let(:patched_string) { PatchedString.new complex }

      it "uses string underscore method" do
        expect(subject.snake(patched_string)).to eq :correct
      end
    end
  end
end

class PatchedString < String
  def underscore
    :correct
  end
end
