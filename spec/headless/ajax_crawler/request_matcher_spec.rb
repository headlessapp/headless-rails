require "spec_helper"
require "headless/ajax_crawler/request_matcher"

RSpec.describe Headless::AjaxCrawler::RequestMatcher do

  describe "call" do

    it "returns false with no fragment" do
      request = request_for_uri("/user/matthewrudy")
      expect(call(request)).to be_false
    end

    it "returns false with no fragment and some params" do
      request = request_for_uri("/user/matthewrudy?foo=bar")
      expect(call(request)).to be_false
    end

    it "returns true with an empty escaped_fragment" do
      request = request_for_uri("/user/matthewrudy?_escaped_fragment_=")
      expect(call(request)).to be_true
    end

    it "returns true with an escaped_fragment" do
      request = request_for_uri("/user/matthewrudy?foo=bar&_escaped_fragment_=/show/twitter")
      expect(call(request)).to be_true
    end

    it "returns false for a POST request, even with an escaped_fragment" do
      request = post_request_for_uri("/user/matthewrudy?foo=bar&_escaped_fragment_=/show/twitter")
      expect(call(request)).to be_false
    end

    def call(request)
      described_class.call(request)
    end
  end
end
