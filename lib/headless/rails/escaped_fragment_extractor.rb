require 'rack/utils'

module Headless
  module Rails
    class EscapedFragmentExtractor < Struct.new(:request)

      def self.call(request)
        new(request).call
      end

      def call
        url = "#{protocol}#{host_with_port}#{path}"
        url << "?#{query_string}" unless query_string.empty?
        url << "##{hash_string}"  unless hash_string.empty?
        url
      end

      private

      def protocol
        request.protocol
      end

      def host_with_port
        request.host_with_port
      end

      def path
        request.path
      end

      def hash_string
        escaped_fragment
      end

      def escaped_fragment
        request.GET[escaped_fragment_key]
      end

      def params_without_fragment
        without = request.GET.dup
        without.delete(escaped_fragment_key)
        without
      end

      def escaped_fragment_key
        ::Headless::Rails::ESCAPED_FRAGMENT_KEY
      end

      def query_string
        ::Rack::Utils.build_query(params_without_fragment)
      end
    end
  end
end
