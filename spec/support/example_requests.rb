module ExampleRequests

  def request_env_for_uri(uri)
    path, query = uri.split("?")

    {
      "SERVER_SOFTWARE"      => "thin 1.5.1 codename Straight Razor",
      "HTTP_VERSION"         => "HTTP/1.1",
      "HTTP_CONNECTION"      => "keep-alive",
      "HTTP_ACCEPT"          => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
      "HTTP_USER_AGENT"      => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.95 Safari/537.36",
      "HTTP_ACCEPT_ENCODING" => "gzip,deflate,sdch",
      "HTTP_ACCEPT_LANGUAGE" => "en-GB,en;q=0.8,en-US;q=0.6,zh;q=0.4",
      "HTTP_COOKIE"          => "foo=bar",
      "GATEWAY_INTERFACE"    => "CGI/1.2",

      "SCRIPT_NAME" => "",
      "REMOTE_ADDR" => "127.0.0.1",

      # http method
      "REQUEST_METHOD" => "GET",

      # protocol
      "SERVER_PROTOCOL" => "HTTP/1.1",
      "rack.url_scheme" => "http",

      # host and port
      "SERVER_NAME" => "localhost",
      "HTTP_HOST"   => "localhost:3000",
      "SERVER_PORT" => "3000",

      # path and query string
      "REQUEST_PATH" => path,
      "PATH_INFO"    => path,
      "REQUEST_URI"  => uri,
      "QUERY_STRING" => query,
    }
  end

  def request_for_uri(uri)
    ::Rack::Request.new(request_env_for_uri(uri))
  end

end