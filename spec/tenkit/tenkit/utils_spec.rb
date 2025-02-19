require_relative "../spec_helper"
RSpec.describe Tenkit::Utils do
  let(:camel) { "someSpecialCaseString" }
  let(:snake) { "some_special_case_string" }

  subject { Tenkit::Utils }

  describe ".snake" do
    let(:complex) { "someAWSCredentials" }
    let(:mangled) { "some_aw_scredentials" }

    it "converts to snake case" do
      expect(subject.snake(camel)).to eq snake
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

  describe ".camel" do
    it "converts to camel case" do
      expect(subject.camel(snake)).to eq camel
    end

    context "when a proper camelize package is available" do
      let(:patched_string) { PatchedString.new snake }

      it "uses string camelize method" do
        expect(subject.camel(patched_string)).to eq :correct
      end
    end
  end
end

class PatchedString < String
  def underscore
    :correct
  end

  def camelize(sym)
    :correct
  end
end
