require 'socket'
require_relative 'request'
require_relative 'response'

class Echo
  def initialize(host: '127.0.0.1', port: 4242)
    @host = host
    @port = port
  end

  def start
    server = TCPServer.new @host, @port
    puts "Listening on #{server.addr[2]}:#{server.addr[1]}"
    begin
      loop do
        Thread.start server.accept do |socket|
          request = Request.new socket
          puts "#{request.method} #{request.path}"
          socket.print Response.new(request).gets
          socket.close
        end
      end
    rescue Exception => e
      puts "Stopped"
    end
  end
end
