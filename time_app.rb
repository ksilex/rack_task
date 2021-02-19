class TimeApp
  FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H',
              'minute' => '%M', 'second' => '%S' }.freeze

  def call(env)
    @request = Rack::Request.new(env)
    response_conditions
  end

  def response_conditions
    return response(404, 'Path error or time format is nil') if (@request.path != '/time' || user_input.nil?)

    if (user_input - FORMATS.keys).empty?
      response(200, time_output)
    else
      response(404, "Unknown time format(s): #{user_input - FORMATS.keys}")
    end
  end

  private

  def response(status, content)
    Rack::Response.new([content], status, { 'Content-Type' => 'text/plain' }).finish
  end

  def user_input
    @request.params['format']&.split(',')
  end

  def time_output
    output = []
    user_input.each { |el| output.push(FORMATS[el]) if FORMATS[el] }
    Time.now.strftime(output.join('-'))
  end
end
