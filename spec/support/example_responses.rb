require 'headless/api_response'

module ExampleResponses
  def json_response
    <<-JSON
    {
      "success":true,
      "url":"http://www.headlessapp.com/",
      "title":"HeadlessApp.com : Headless Browsing as-a-service",
      "status_message":"success",
      "http_status_code":200,
      "content":"<h1>HeadlessApp</h1>"
    }
    JSON
  end

  def api_response
    Headless::APIResponse.new(json_response)
  end
end