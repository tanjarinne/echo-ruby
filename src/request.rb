class Request
  attr_reader :method
  attr_reader :path
  attr_reader :version
  attr_reader :headers
  attr_reader :data

  def initialize(socket)
    buffer = socket.gets
    @method, @path, @version = buffer.split(' ')
    @headers = {}
    while buffer = socket.gets.split(' ', 2)
      break if buffer[0] == ""
      headers[buffer[0].chop] = buffer[1].strip
    end
    @data = socket.read(@headers["Content-Length"].to_i)
  end
end
