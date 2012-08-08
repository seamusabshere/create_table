#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.rspec_opts = ['--format', 'documentation']
end

task :default => :spec

task :ragel do
  require 'posix/spawn'
  $stderr.write "Recompiling ragel..."
  if (child = POSIX::Spawn::Child.new('ragel', '-R', '-F1', File.expand_path('../lib/create_table.rl', __FILE__))).status.success?
    $stderr.puts "succeeded."
  else
    raise "Error was #{child.err}"
  end
end
