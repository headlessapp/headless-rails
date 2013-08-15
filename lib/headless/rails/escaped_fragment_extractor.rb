require 'rack/utils'

module Headless
  module Rails
    class EscapedFragmentExtractor < Struct.new(:request)

      def self.call(request)
        new(request).call
      end

      def call
        url = "#{scheme}://#{host_with_port}#{path}"
        url << "?#{query_string}"      unless query_string.empty?
        url << "##{escaped_fragment}"  unless escaped_fragment.nil? || escaped_fragment.empty?
        url
      end

      private

      # delegate to request

      def scheme
        request.scheme
      end

      def host_with_port
        request.host_with_port
      end

      def path
        request.path
      end

      def get_params
        request.GET
      end

      # extract the fragment

      def escaped_fragment
        get_params[escaped_fragment_key]
      end

      def params_without_fragment
        without = get_params.dup
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
