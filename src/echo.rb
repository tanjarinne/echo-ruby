require 'socket'

server = TCPServer.new ENV.fetch('ECHO_HOST', 'localhost'), ENV.fetch('ECHO_PORT', 4242)
puts "Listening on %s\n" % server.addr.join(":")

begin
  loop do
    Thread.start server.accept do |client|
      print client
      client.puts "hey"
      client.puts "Time is #{Time.now}"
      client.close
    end
  end
rescue Exception => e
  puts "Stopped"
end