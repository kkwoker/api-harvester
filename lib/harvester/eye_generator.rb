require_relative '../../template/default_eye'

module EyeGenerator
  def self.create_eye_config name
    config = Default.eye_config name
    File.open("#{name}.d/config.eye", 'w') { |file| file.write(config)}
  end

  def self.create_puller name, endpoint, timeout
    puller = Default.puller name, endpoint, timeout
    File.open("#{name}.d/puller.rb", 'w') { |file| file.write(puller)}
  end

  def self.create_parser name, endpoint
    parser = Default.parser name, endpoint
    File.open("#{name}.d/parser.rb", 'w') { |file| file.write(parser)}
  end

  def self.create_pusher name, endpoint
    pusher = Default.pusher name, endpoint
    File.open("#{name}.d/pusher.rb", 'w') { |file| file.write(pusher)}
  end

  def self.initialize name, endpoint, timeout
    system "mkdir -p #{name}.d"
    system "mkdir -p #{name}.d/logs"
    system "mkdir -p #{name}.d/pids"
    create_eye_config name
    create_puller name, endpoint, timeout
    create_parser name, endpoint
    create_pusher name, endpoint
  end
end
