require "faraday"

module HTTP
  DEFAULT_CONFIGURATION = {
    request_timeout: 10
  }.freeze

  def get(path, opts = {})
    res = conn.get("#{@base_uri}#{path}", opts) do |req|
      req.headers = headers
    end
    res.body
  end

  def post(path, opts = {})
    res = conn.post("#{@base_uri}#{path}", opts[:body].to_json) do |req|
      req.headers = headers
    end
    res.body
  end

  private

  def conn
    @conn ||= Faraday.new do |builder|
      # Sets the Content-Type header to application/json on each request.
      # Also, if the request body is a Hash, it will automatically be encoded as JSON.
      builder.request :json

      # Parses JSON response bodies.
      # If the response body is not valid JSON, it will raise a Faraday::ParsingError.
      builder.response :json

      builder.options[:timeout] = @request_timeout
    end
  end

  def headers
    base_headers.merge(@extra_headers || {})
  end

  def base_headers
    {
      "User-Agent" => "Faraday"
    }
  end
end

class JsonPlaceholderClient
  include HTTP

  CONFIG_KEYS = %i[
    base_uri
    extra_headers
    request_timeout
  ].freeze

  attr_reader(*CONFIG_KEYS)

  def initialize(config = {})
    CONFIG_KEYS.each do |key|
      # Set config as instance variables; fall back to global config if not provided
      key_value = config[key] || DEFAULT_CONFIGURATION[key]

      instance_variable_set("@#{key}", key_value)
    end
  end

  def get_posts(opts: {})
    get("/posts", opts)
  end

  def create_post(opts: {})
    post("/posts", { body: opts[:body] })
  end
end

api_opts = {
  base_uri: "https://jsonplaceholder.typicode.com"
}
json_placeholder = JsonPlaceholderClient.new(api_opts)

res = json_placeholder.get_posts
puts res

post_res = json_placeholder.create_post(opts: { body: {
                                          title:  "foo",
                                          body:   "bar",
                                          userId: 1
                                        } })
puts post_res
