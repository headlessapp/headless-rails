$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'headless/rails'
require 'support/example_requests'

RSpec.configure do |c|
  c.include ExampleRequests
end
