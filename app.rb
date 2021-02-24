require_relative 'time_formatter'
class App
  def call(env)
    @request = Rack::Request.new(env)
    time_service_call
  end

  def time_service_call
    return response(404, 'Path error or time format is nil') if (@request.path != '/time' || user_input.nil?)

    time_service = TimeFormatter.new(user_input)
    if time_service.input_valid?
      response(200, time_service.time_output)
    else
      response(404, "Unknown time format(s): #{time_service.unknown_formats}")
    end
  end

  private

  def response(status, content)
    Rack::Response.new([content], status, { 'Content-Type' => 'text/plain' }).finish
  end

  def user_input
    @request.params['format']&.split(',')
  end
end
