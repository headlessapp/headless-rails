require 'spec_helper'
require 'rack/request'

RSpec.describe Headless::Rails::EscapedFragmentExtractor do

  describe "call" do

    context "with no escaped_fragment" do
      subject do
        described_class.call(example_request)
      end

      it "returns a full url" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy"
      end
    end

    context "with an empty escaped_fragment" do
      subject do
        described_class.call(example_request_with_fragment(""))
      end

      it "returns a full url with the escaped fragment removed" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy"
      end
    end

    context "with an escaped_fragment" do
      subject do
        described_class.call(example_request_with_fragment("/show/twitter"))
      end

      it "returns the full url with an anchor appended" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy#/show/twitter"
      end
    end
  end
end