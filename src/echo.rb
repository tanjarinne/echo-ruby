require 'socket'

socket = TCPServer.new 4242

loop do
  client = socket.accept
  client.puts "hey"
  client.puts "Time is #{Time.now}"
  client.close
end