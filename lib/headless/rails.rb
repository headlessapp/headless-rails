require "headless/rails/version"
require "headless/rails/escaped_fragment_extractor"
require "headless/api_client"

module Headless
  module Rails

    ESCAPED_FRAGMENT_KEY = "_escaped_fragment_".freeze

    def respond_to_ajax_crawlers
      if params.has_key?(ESCAPED_FRAGMENT_KEY)
        url = EscapedFragmentExtractor.call(request)
        crawled = ::Headless::APIClient.crawl(url)
        render text: crawled.content
      end
    end

  end
end
