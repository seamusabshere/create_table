require 'bundler/setup'

Bundler.with_clean_env do
  system %{rake ragel}
  raise RuntimeError unless $?.success?
end

require 'rspec/expectations'
require 'active_record'

system %{ mysql -u root -ppassword -e "DROP DATABASE IF EXISTS create_table_test" }
system %{ mysql -u root -ppassword -e "CREATE DATABASE create_table_test CHARSET utf8" }
ENV['DATABASE_URL'] ||= 'mysql2://root:password@127.0.0.1/create_table_test'
ActiveRecord::Base.establish_connection

require 'create_table'
