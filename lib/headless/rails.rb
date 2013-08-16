require "headless/rails/version"
require "headless/ajax_crawler/middleware"

module Headless
  module Rails
    Middleware = Headless::AjaxCrawler::Middleware
  end
end
