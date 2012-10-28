require 'em-http'

# Kermit Client wich will connect to the kermit websocket server
class KermitClient

  attr_accessor :websocket_host, :websocket_port

  # Starts the WebSocket client to consume the tweets
  def start

    EventMachine.run do

      puts '='*80, "Connecting to websockets server at ws://#{websocket_host}:#{websocket_port}", '='*80

      http = EventMachine::HttpRequest.new("ws://#{websocket_host}:#{websocket_port}/websocket").get :timeout => 0

      http.errback do
        puts.error "something was wrong in the websocket_client"
      end

      http.callback do
        puts "#{Time.now.strftime('%H:%M:%S')} : Connected to server"
      end

      http.stream do |msg|
        puts msg
      end

    end

  end

end