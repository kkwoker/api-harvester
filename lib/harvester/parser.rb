require 'pry'
require 'ezmq'
require 'msgpack'
require 'oj'
require_relative 'settings'
module Parser
  @broadcaster = EZMQ::Publisher.new :bind, port: 6060, encode: -> m { Oj.dump m }
  def self.activate topic, endpoint
    puts topic, endpoint
    listener = EZMQ::Subscriber.new :connect, port: 5050, topic: topic, decode: -> m { Oj.load m }
    listener.listen do |message, topic|
      data = plow message, topic
      data.each do |item|
        puts @broadcaster.send item, topic: topic
      end
    end
  end

  def self.plow message, parse
    require_relative "../../parser_functions/#{parse}"
    send(parse, message)
  end
end
