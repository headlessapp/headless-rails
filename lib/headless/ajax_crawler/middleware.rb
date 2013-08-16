require "rack/request"
require "headless/ajax_crawler/request_matcher"
require "headless/ajax_crawler/url_extractor"
require "headless/api_client"

module Headless
  module AjaxCrawler
    class Middleware < Struct.new(:app)
      def call(env)
        request = ::Rack::Request.new(env)

        if ::Headless::AjaxCrawler::RequestMatcher.call(request)
          url = ::Headless::AjaxCrawler::UrlExtractor.call(request)
          api_response = ::Headless::APIClient.crawl(url)

          if api_response.success?
            http_status = api_response.http_status_code || 200
            return [http_status, { 'Content-Type' => "text/html" }, [api_response.content]]
          else
            raise "headless request for #{url} failed: #{crawled}"
          end
        end

        app.call(env)
      end
    end
  end
end