class TimeFormatter
  attr_reader :user_input

  FORMATS = { 'year' => '%Y', 'month' => '%m', 'day' => '%d', 'hour' => '%H',
              'minute' => '%M', 'second' => '%S' }.freeze

  def initialize(user_input)
    @user_input = user_input
  end

  def input_valid?
    (user_input - FORMATS.keys).empty?
  end

  def unknown_formats
    user_input - FORMATS.keys
  end

  def time_output
    output = []
    user_input.each { |el| output.push(FORMATS[el]) if FORMATS[el] }
    Time.now.strftime(output.join('-'))
  end
end
