#!/usr/bin/env ruby

require 'rubygems'
require 'commander/import'
require 'lib/kermit_client'
require 'lib/fnord_metric_app.rb'

program :version, '1.0'
program :description, 'Combination of kermit and CLD gems to perform language detection on tweets using Google CLD\'s bindings to Ruby'

default_command :start

command :start do |c|
  c.syntax = 'Twitter CLD start [options]'
  c.summary = 'Starts listening to Kermit and performing CLD'
  c.description = 'Starts listening to Kermit and performing CLD.  It requires that Kermit is up and running.'
  c.option '--websocket_host', 'Host of the kermit websocket server (default localhost)'
  c.option '--websocket_port', 'Port of the kermit websocket server (default 8000)'
  c.action do |args, options|
    client = KermitClient.new
    client.websocket_host = options.websocket_host || 'localhost'
    client.websocket_port = options.websocket_port || '8000'
    client.start
  end
end

command :metrics do |c|
  c.syntax = 'Twitter CLD metrics'
  c.summary = 'Starts the fnordmetric app'
  c.description = 'Starts the fnordmetric app'
  c.action do |args, options|
    metrics_app = FnordMetricApp.new
    metrics_app.start
  end
end

