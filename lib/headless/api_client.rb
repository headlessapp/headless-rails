require "rest_client"
require "json"

module Headless
  class APIClient

    def self.crawl(url)
      new.crawl(url)
    end

    def crawl(url)
      APIResponse.new(get("/api/crawl", :url => url))
    end

    class APIResponse < Struct.new(:response)

      def content
        parsed_response["content"]
      end

      private

      def parsed_response
        @parsed_response ||= ::JSON.parse(response)
      end
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
