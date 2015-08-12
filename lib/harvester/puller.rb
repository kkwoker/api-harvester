require 'ezmq'
require 'msgpack'
require 'faraday'
require 'oj'
require 'excon'
require_relative 'settings'

module Puller
  @broadcaster = EZMQ::Publisher.new :bind, port: 5000
  def self.fetch_data(endpoint)
    conn = Faraday.new(url: endpoint) do |faraday|
      faraday.adapter :excon
      faraday.headers['X-Api-Key'] = Settings.newrelic_key
    end
    conn.get.body
  # rescue Exception => e
  #   puts "Puller#fetch_data"
  #   puts "#{e.inspect}: #{e.message}"
  end

  def self.send(data, topic)
    # puts "Puller#send"
    @broadcaster.send data, topic: topic
  end

  def self.activate(name, endpoint, timeout)
    loop do
      puts send fetch_data(endpoint), name
      sleep timeout
    end
  end
end
