class FakeSlack
  attr_reader :last_request

  def call(env)
    request = Rack::Request.new(env)
    @last_request = Request.new(request.path, request.params, request.body.read)
    [200, {}, ['OK']]
  end

  class Request < Struct.new(:path, :params, :body); end
end
