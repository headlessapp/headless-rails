require "headless/api_response"
require "rest_client"

module Headless
  class APIClient

    def self.crawl(url)
      new.crawl(url)
    end

    def crawl(url)
      ::Headless::APIResponse.new(get("/api/crawl", :url => url))
    end

    private

    def get(path, params)
      ::RestClient.get(url_for(path), :params => params)
    end

    def url_for(path)
      "#{headless_protocol}://#{headless_host}#{path}"
    end

    def headless_host
      "api.headlessapp.com"
    end

    def headless_protocol
      "http"
    end
  end
end
