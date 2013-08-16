require "headless/rails/version"
require "headless/ajax_crawler"
require "headless/api_client"

module Headless
  module Rails

    def respond_to_ajax_crawlers
      if ::Headless::AjaxCrawler::RequestMatcher.call(request)
        url = ::Headless::AjaxCrawler::UrlExtractor.call(request)
        crawled = ::Headless::APIClient.crawl(url)
        render :text => crawled.content if crawled.success?
      end
    end

  end
end
