require 'socket'

class Echo
  def initialize(host: '127.0.0.1', port: 4242)
    @host = host
    @port = port
  end

  def start
    server = TCPServer.new @host, @port
    puts "Listening on %s:%s" % [server.addr[2], server.addr[1]]
    begin
      loop do
        Thread.start server.accept do |session|
          request = Request.new session
          puts "#{request.method} #{request.path}"
          session.print "HTTP/1.1 200\r\n"
          session.print "Content-Type: text/html\r\n"
          session.print "\r\n"
          session.print "#{request.method} #{request.path} #{request.version}\r\n"
          session.print "#{request.headers.map{|e| e.join(': ') }.join("\r\n")}"
          session.close
        end
      end
    rescue Exception => e
      puts "Stopped"
    end
  end
end

class Request
  attr_reader :method
  attr_reader :path
  attr_reader :version
  attr_reader :headers

  def initialize(socket)
    @@socket = socket
    buffer = @@socket.gets
    @method, @path, @version = buffer.split(' ')
    @headers = extract_headers()
  end

  def extract_headers
    headers = {}
    line = ''
    while line = @@socket.gets
      break if line =~ /^\r\n$/
      header, value = line.split(/:\s*/, 2)
      headers[header] = value.to_s().gsub(/\r\n/, '')
    end
    headers
  end
end
