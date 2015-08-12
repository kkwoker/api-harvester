require 'pry'
require 'ezmq'
require 'oj'
require 'influxdb'
require_relative 'settings'

module Pusher
  @connection = InfluxDB::Client.new host: Settings.influx_host, username: Settings.influx_user, password: Settings.influx_pass

  def self.activate topic, endpoint
    listener = EZMQ::Subscriber.new :connect, port: 6000, topic: topic, decode: -> m { Oj.load m }
    listener.listen do |message, topic|
      puts write message
    end
  end

  def self.write data
    series = data.delete :series_name
    db = data.delete :database_name
    use_or_create db
    @connection.write_point(series, data)
    data.length
  end

  def self.use_or_create(db_name)
    dbs = @connection.get_database_list.map { |db| db["name"] }
    @connection.create_database db_name unless dbs.include? db_name
    @connection = InfluxDB::Client.new db_name, host: Settings.influx_host, 
                                              username: Settings.influx_user, 
                                              password: Settings.influx_pass
  end

end
