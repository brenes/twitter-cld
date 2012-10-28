require 'em-http'
require 'json'
require 'cld'

# Kermit Client wich will connect to the kermit websocket server
class KermitClient

  attr_accessor :websocket_host, :websocket_port, :language_tweets, :metrics_api

  # Starts the WebSocket client to consume the tweets
  def start

    EventMachine.run do

      self.language_tweets = {}
      self.metrics_api = FnordMetric::API.new

      puts '='*80, "Connecting to websockets server at ws://#{websocket_host}:#{websocket_port}", '='*80

      http = EventMachine::HttpRequest.new("ws://#{websocket_host}:#{websocket_port}/websocket").get :timeout => 0

      http.errback do
        puts.error "something was wrong in the websocket_client"
      end

      http.callback do
        puts "#{Time.now.strftime('%H:%M:%S')} : Connected to server"
      end

      http.stream do |msg|
        tweet = JSON.parse(msg)
        cld_info = CLD.detect_language(tweet['text'])

        language = cld_info[:reliable] ? cld_info[:name] : "unreliable"
        language_tweets[language] ||= 0
        language_tweets[language] += 1

        metrics_api.event(:_type => :tweet_processed, :language => cld_info[:name], :reliable => cld_info[:reliable])
        puts language_tweets.sort_by{|key, value| -value }.inspect

      end

    end

  end

end