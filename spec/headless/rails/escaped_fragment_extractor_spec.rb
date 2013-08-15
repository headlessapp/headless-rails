require 'spec_helper'
require 'rack/request'

RSpec.describe Headless::Rails::EscapedFragmentExtractor do

  let(:request_env) do
    {
      "SERVER_SOFTWARE"=>"thin 1.5.1 codename Straight Razor",
      "SERVER_NAME"=>"localhost",
      "REQUEST_METHOD"=>"GET",
      "REQUEST_PATH"=>"/user/matthewrudy",
      "PATH_INFO"=>"/user/matthewrudy",
      "REQUEST_URI"=>"/user/matthewrudy",
      "HTTP_VERSION"=>"HTTP/1.1",
      "HTTP_HOST"=>"localhost:3000",
      "HTTP_CONNECTION"=>"keep-alive",
      "HTTP_ACCEPT"=>"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "HTTP_USER_AGENT"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36",
      "HTTP_ACCEPT_ENCODING"=>"gzip,deflate,sdch",
      "HTTP_ACCEPT_LANGUAGE"=>"en-GB,en;q=0.8,en-US;q=0.6,zh;q=0.4",
      "HTTP_COOKIE"=>"foo=bar",
      "GATEWAY_INTERFACE"=>"CGI/1.2",
      "SERVER_PORT"=>"3000",
      "QUERY_STRING"=>"",
      "SERVER_PROTOCOL"=>"HTTP/1.1",
      "rack.url_scheme"=>"http",
      "SCRIPT_NAME"=>"",
      "REMOTE_ADDR"=>"127.0.0.1",
    }
  end

  def request_env_with_fragment(escaped_fragment)
    request_env.merge(
      "QUERY_STRING"=>"_escaped_fragment_=#{escaped_fragment}",
      "REQUEST_URI"=>"/user/matthewrudy?_escaped_fragment_=#{escaped_fragment}"
    )
  end

  def request_with_fragment(escaped_fragment)
    ::Rack::Request.new(request_env_with_fragment(escaped_fragment))
  end

  describe "call" do

    context "with an empty escaped_fragment" do
      subject do
        described_class.call(request_with_fragment(""))
      end

      it "returns a full url with the escaped fragment removed" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy"
      end
    end

    context "with an escaped_fragment" do
      subject do
        described_class.call(request_with_fragment("/show/twitter"))
      end

      it "returns the full url with an anchor appended" do
        expect(subject).to eq "http://localhost:3000/user/matthewrudy#/show/twitter"
      end
    end
  end
end