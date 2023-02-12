require 'socket'
require_relative 'request'

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
          session.print "#{request.headers.map{|e| e.join(': ') }.join("\r\n")}\r\n"
          session.print "#{request.data}"
          session.close
        end
      end
    rescue Exception => e
      puts "Stopped"
    end
  end
end
