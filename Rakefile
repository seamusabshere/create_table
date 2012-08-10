#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:rspec) do |spec|
  spec.rspec_opts = ['--format', 'documentation']
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = %w{--format pretty}
end

task :default => [:cucumber, :rspec]

task :ragel do
  require 'posix/spawn'
  Dir[File.expand_path('../lib/create_table/**/*.rl', __FILE__)].each do |path|
    $stderr.write "Compiling Ragel from #{path}..."
    if (child = POSIX::Spawn::Child.new('ragel', '-R', '-F1', path)).status.success?
      $stderr.puts "succeeded."
    else
      raise "Error was #{child.err}"
    end
  end
end
