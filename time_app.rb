require 'rack'

FORMATS = %w[year month day hour minute second].freeze
class TimeApp
  def call(env)
    @request = Rack::Request.new(env)
    response.finish
  end

  def response
    if @request.path != "/time"
      Rack::Response.new(['error'], 404, { 'Content-Type' => 'text/plain' })
    else
      @request.params
      Rack::Response.new(['time'], 200, { 'Content-Type' => 'text/plain' })
    end
  end

end
