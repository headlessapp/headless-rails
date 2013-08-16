require 'spec_helper'
require 'rack/test'

RSpec.describe Headless::AjaxCrawler::Middleware do

  include Rack::Test::Methods
  include ExampleResponses

  def app
    hello_world = lambda { |env|
      headers = { 'Content-Type' => "text/html" }
      [200, headers, ['Hello world!']]
    }
    Headless::AjaxCrawler::Middleware.new(hello_world)
  end

  let(:headless_response) { api_response }

  context "regular url" do
    it "renders hello world" do
      get "/"
      expect(last_response.body).to include("Hello world")
    end
  end

  context "with an escaped_fragment" do
    it "call headless and renders it" do
      expect(Headless::APIClient).to receive(:crawl).and_return(headless_response)
      get "/?_escaped_fragment_="
      expect(last_response.body).to include("HeadlessApp")
    end

    context "a POST" do
      it "renders hello world" do
        post "/?_escaped_fragment_="
        expect(last_response.body).to include("Hello world")
      end
    end
  end
end

