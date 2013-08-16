require "json"

module Headless
  class APIResponse < Struct.new(:response)

    def success?
      parsed_response["success"]
    end

    def content
      parsed_response["content"]
    end

    def http_status_code
      parsed_response["http_status_code"]
    end

    private

    def parsed_response
      @parsed_response ||= ::JSON.parse(response)
    end
  end
end