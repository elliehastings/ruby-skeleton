require 'rake'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :main do
  ruby "main.rb"
end

task :server do
  ruby "server.rb"
end

task :test => :spec
