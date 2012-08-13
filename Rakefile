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
  require 'active_support/core_ext'
  require 'fileutils'
  Dir[File.expand_path('../lib/**/*.rl', __FILE__)].each do |path|
    next if File.basename(path).include?('common')
    $stderr.write "#{File.basename(path)}:"
    debugged = "#{path}.tmp"
    if ENV['VERBOSE'] == 'true'
      $stderr.write " adding debugging to #{File.basename(debugged)}..."
      lines = IO.readlines(path).map(&:chomp)
      File.open(debugged, 'w') do |f|
        lines.each do |line|
          f.puts line
          if line =~ /action (.*) \{/
            action = $1
            base = action.sub(/^(Mark|Start|End)/, '').underscore
            vars = [ "mark_#{base}", "start_#{base}", "end_#{base}", 'end_data_type', 'quote_value' ].uniq
            l1 = []
            l1 << "p=\#{p} \#{data[p..p].pack('c*').inspect}"
            l2 = vars.map { |name| "#{name}=\#{#{name}.inspect if defined?(#{name})}" }
            start = "start_#{base}"
            f.puts <<-EOS
if ENV['VERBOSE'] == 'true'
  $stderr.puts "\n#{action}\n  #{l1.join(', ')}\n  #{l2.join(', ')}"
  if defined?(#{start}) and #{start}
    $stderr.puts '  ***' + read(data, #{start}, p).inspect
  end
end
EOS
          end
        end
      end
    else
      # didn't add
      FileUtils.cp path, debugged
    end
    ragel = "#{path}.rb"
    $stderr.write " compiling Ragel to #{File.basename(ragel)}..."
    if (child = POSIX::Spawn::Child.new('ragel', '-R', '-F1', debugged)).status.success?
      # File.unlink debugged
    else
      raise "Error: #{child.err}"
    end
    final = ragel.sub('.rl.rb', '.rb')
    $stderr.write " moving to #{File.basename(final)}.\n"
    FileUtils.mv ragel, final
  end
end
