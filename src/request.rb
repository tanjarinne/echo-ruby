class Request
  attr_reader :method
  attr_reader :path
  attr_reader :version
  attr_reader :headers
  attr_reader :data

  def initialize socket
    buffer = socket.gets
    @method, @path, @version = buffer.split ' '
    @headers = {}
    while (line = socket.gets) != "\r\n"
      header, value = line.split ':', 2
      headers[header.chomp] = value.chomp
    end
    @data = socket.read @headers["Content-Length"].to_i
  end
end
