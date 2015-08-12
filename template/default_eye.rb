module Default


  def self.puller name, endpoint, timeout
    %Q(#!/bin/env ruby
require_relative '../lib/harvester/puller'
Puller.activate("#{name}", "#{endpoint}", #{timeout})
)
  end

  def self.parser name, endpoint
    %Q(#!/bin/env ruby
require_relative '../lib/harvester/parser'
Parser.activate("#{name}", "#{endpoint}")
)
  end

  def self.pusher name, endpoint
    %Q(#!/bin/env ruby
require_relative '../lib/harvester/pusher'
Pusher.activate("#{name}", "#{endpoint}")
)
  end

  def self.eye_config name
    %Q(#!/bin/env ruby

Eye.application 'harvester' do

  working_dir File.expand_path(File.join(File.dirname(__FILE__)))
  
  group "#{name}" do
    process :puller do
      pid_file 'pids/puller.pid'
      start_command "ruby puller.rb"
      daemonize true
      stdout 'logs/puller.log'
      check :memory, every: 20.seconds, below: 300.megabytes, times: 3
    end

    process :parser do
      pid_file 'pids/parser.pid'
      start_command "ruby parser.rb"
      daemonize true
      stdout 'logs/parser.log'
      check :memory, every: 20.seconds, below: 300.megabytes, times: 3
    end

    process :pusher do
      pid_file 'pids/pusher.pid'
      start_command "ruby pusher.rb"
      daemonize true
      stdout 'logs/pusher.log'
      check :memory, every: 20.seconds, below: 300.megabytes, times: 3
    end

  end
end
)
  end

end
