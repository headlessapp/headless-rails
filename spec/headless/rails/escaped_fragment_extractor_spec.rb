require 'spec_helper'
require 'rack/request'

RSpec.describe Headless::Rails::EscapedFragmentExtractor do

  describe "call" do

    let(:request) { request_for_uri(uri) }

    subject do
      described_class.call(request)
    end

    context "with no escaped_fragment" do

      let(:uri) { "/user/matthewrudy" }

      it "returns a full url" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy"
      end
    end

    context "with some params" do

      let(:uri) { "/user/matthewrudy?foo=bar" }

      it "keeps the params intact" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy?foo=bar"
      end
    end

    context "with an empty escaped_fragment" do

      let(:uri) { "/user/matthewrudy?_escaped_fragment_=" }

      it "returns a full url with the escaped fragment removed" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy"
      end
    end

    context "with an escaped_fragment" do

      let(:uri) { "/user/matthewrudy?_escaped_fragment_=/show/twitter" }

      it "returns the full url with an anchor appended" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy#/show/twitter"
      end
    end

    context "with an escaped_fragment and some params" do

      let(:uri) { "/user/matthewrudy?foo=bar&_escaped_fragment_=/show/twitter" }

      it "returns the full url with an anchor appended" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy?foo=bar#/show/twitter"
      end
    end
  end
end