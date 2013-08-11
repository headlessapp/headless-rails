require "spec_helper"

RSpec.describe Headless::APIClient do

  subject do
    Headless::APIClient
  end

  describe "crawl" do
    it "returns a response" do
      response = subject.crawl("http://matthewrudy.com")
      expect(response.content).to include("Matthew Rudy Jacobs")
    end
  end

end