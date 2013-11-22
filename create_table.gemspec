# -*- encoding: utf-8 -*-
require File.expand_path('../lib/create_table/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Seamus Abshere"]
  gem.email         = ["seamus@abshere.net"]
  gem.description   = %q{Analyze and inspect CREATE TABLE SQL statements and translate across databases.}
  gem.summary       = %q{Analyze and inspect CREATE TABLE SQL statements and translate across databases.}
  gem.homepage      = "https://github.com/seamusabshere/create_table"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "create_table"
  gem.require_paths = ["lib"]
  gem.version       = CreateTable::VERSION

  gem.add_development_dependency 'rspec-core'
  gem.add_development_dependency 'rspec-expectations'
  gem.add_development_dependency 'rspec-mocks'
  gem.add_development_dependency 'posix-spawn'
  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'mysql2'
  gem.add_development_dependency 'pg'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rake'
end
