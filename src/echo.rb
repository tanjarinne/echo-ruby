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
        Thread.start server.accept do |client|
          client.print "HTTP/1.1 200\r\n"
          client.print "Content-Type: text/html\r\n"
          client.print "\r\n"
          client.print "Hello world! The time is #{Time.now}"
          client.close
        end
      end
    rescue Exception => e
      puts "Stopped"
    end
  end
end
