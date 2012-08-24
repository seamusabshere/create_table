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

task :rspec_all_databases do
  require 'posix-spawn'
  %w{ postgresql mysql sqlite3 }.each do |db|
    puts
    puts '#'*50
    puts "# Running specs against #{db}"
    puts '#'*50
    puts
    pid = POSIX::Spawn.spawn({'DB' => db}, 'rspec', File.expand_path('../spec', __FILE__))
    Process.waitpid pid
  end
end

task :default => [:cucumber, :rspec_all_databases]

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
          if line =~ /action ([^{]*) \{([^}]*)\}?/
            action = $1.strip
            inline = $2.strip
            is_inline = inline.length > 0
            base = action.sub('Quoted', '').sub('Unquoted', '').sub(/^(Mark|Start|End)/, '').underscore
            vars = [ "mark_#{base}", "start_#{base}", "end_#{base}", 'end_data_type' ].uniq
            l1 = []
            l1 << "p=\#{p} \#{data[p..p].pack('c*').inspect}"
            l2 = vars.map { |name| "#{name}=\#{#{name}.inspect if defined?(#{name})}" }
            start = "start_#{base}"
            pre = <<-EOS
$stderr.puts "\n#{action}\n  #{l1.join(', ')}\n  #{l2.join(', ')}"
if defined?(#{start}) and #{start}
  $stderr.puts '  ***' + read(data, #{start}, p).inspect
end
EOS
            if is_inline
              f.puts "action #{action} {"
              f.puts pre
              f.puts inline
            else
              f.puts line
              f.puts pre
            end
            if is_inline
              f.puts '}'
            end
          else
            f.puts line
          end
        end
      end
    else
      # didn't add
      FileUtils.cp path, debugged
    end
    ragel = "#{path}.rb"
    $stderr.write " compiling Ragel to #{File.basename(ragel)}..."
    if (child = POSIX::Spawn::Child.new('ragel', '-R', '-L', debugged)).status.success?
      # File.unlink debugged
    else
      raise "Error: #{child.err}"
    end
    final = ragel.sub('.rl.rb', '.rb')
    $stderr.write " moving to #{File.basename(final)}.\n"
    FileUtils.mv ragel, final
  end
end
