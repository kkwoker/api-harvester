Gem::Specification.new do |gem|
  gem.name        = 'api-harvester'
  gem.version     = '0.0.9'
  gem.licenses    = 'MIT'
  gem.authors     = ['Kinnan Kwok']
  gem.email       = 'kkwoker@gmail.com'
  gem.summary     = 'Allows you to specify an endpoint to retrieve data from, parse it, and store into any database'
  gem.require_paths = ["lib"]
  gem.bindir        = 'bin'
  gem.executables   = ["harvester"]
  gem.files         = [
    ".document",
    ".gitignore",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "parser_functions/key_transactions.rb",
    "template/default_eye.rb",
    "bin/harvester",
    "api-harvester.gemspec",
    "lib/harvester.rb",
    "lib/harvester/eye_generator.rb",
    "lib/harvester/parser.rb",
    "lib/harvester/pusher.rb",
    "lib/harvester/puller.rb",
    "lib/harvester/settings.rb"
  ]

  gem.homepage = "http://github.com/kkwoker/api-harvester"
  gem.add_runtime_dependency 'ezmq', '~> 0.4.4'
  gem.add_runtime_dependency 'faraday'
  gem.add_runtime_dependency 'excon'
  gem.add_runtime_dependency 'commander'
  gem.add_runtime_dependency 'msgpack'
  gem.add_runtime_dependency 'influxdb', '~> 0.1.9'
  gem.add_runtime_dependency 'eye'
  gem.add_runtime_dependency 'moneta'
  gem.add_runtime_dependency 'sinatra'
  gem.add_runtime_dependency 'rainbow'
  gem.add_runtime_dependency 'oj'
  gem.add_runtime_dependency 'terminal-announce'
  gem.add_runtime_dependency 'settingslogic'

  gem.add_development_dependency 'pry'
end
