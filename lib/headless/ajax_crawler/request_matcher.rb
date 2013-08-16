require "headless/ajax_crawler"

module Headless
  module AjaxCrawler
    class RequestMatcher < Struct.new(:request)

      def self.call(request)
        new(request).match?
      end

      def match?
        is_get? && has_escaped_fragment?
      end

      private

      def is_get?
        request.get?
      end

      def has_escaped_fragment?
        get_params.has_key?(escaped_fragment_key)
      end

      def escaped_fragment_key
        ::Headless::AjaxCrawler::ESCAPED_FRAGMENT_KEY
      end

      def get_params
        request.GET
      end
    end
  end
end