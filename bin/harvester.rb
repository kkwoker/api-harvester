#!/usr/bin/env ruby

require 'commander'
require_relative '../lib/harvester'

Commander.configure do
  program :name, 'Harvester'
  program :version, '0.0.1'
  program :description, 'harvest from endpoints'
  program :help, 'Author', 'Kinnan Kwok <kkwoker@gmail.com>'

  default_command :harvest

  command :harvest do |command|
    command.syntax = 'harvester harvest [options]'
    command.summary = ''
    command.description = 'Starts processes for harvesting data'
    command.example 'description', 'command example'
    command.option '--from STRING', String, 'Adds an endpoint to harvest from'
    command.option '--with STRING', String, 'Adds a parsing method ruby file'
    command.option '--every INTEGER', Integer, 'Adds an interval for polling'
    command.action do |_args, options|
      # Do something or c.when_called Harvester::Commands::Harvest
      abort 'Must provide parameters --from, --with, and --every' unless options.from && options.with && options.every
      name = options.with
      endpoint = options.from
      timeout = options.every

      # Create an eye file.
      EyeGenerator.initialize name, endpoint, timeout
      # Load Eye file
      system "eye load #{name}.d/config.eye"
      system "eye restart #{name}"
      
    end
  end
end
