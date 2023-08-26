# See usage documentation at https://github.com/jnunemaker/httparty
# Examples at https://github.com/jnunemaker/httparty/tree/master/examples

require 'httparty'

class ApiManager
  include HTTParty

  attr_reader :base_uri

  def initialize(base_uri)
    @base_uri = base_uri
  end

  def get(child_route, opts = {})
    self.class.get("#{base_uri}#{child_route}", opts)
  end

  def post(child_route, opts = {})
    self.class.post("#{base_uri}#{child_route}", opts).parsed_response
  end
end

api_manager = ApiManager.new('https://jsonplaceholder.typicode.com')
res = api_manager.get('/posts')
puts res

post_body = {
  title: 'foo',
  body: 'bar',
  userId: 1,
}
opts = {headers: {"User-Agent" => "Httparty"}}
post_res = api_manager.post('/posts', { body: post_body, **opts})
puts post_res
