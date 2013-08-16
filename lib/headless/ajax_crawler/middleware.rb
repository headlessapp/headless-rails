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
          crawled = ::Headless::APIClient.crawl(url)

          if crawled.success?
            return [200, { 'Content-Type' => "text/html" }, [crawled.content]]
          end
        end

        app.call(env)
      end
    end
  end
end