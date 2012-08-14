require 'bundler/setup'

Bundler.with_clean_env do
  system %{rake ragel}
  raise RuntimeError unless $?.success?
end

require 'active_record'

ENV['DB'] ||= 'mysql'
case ENV['DB']
when 'postgresql'
  system %{ dropdb create_table_test }
  system %{ createdb create_table_test }
  ActiveRecord::Base.establish_connection :adapter => 'postgresql', :database => 'create_table_test'
when 'mysql'
  system %{ mysql -u root -ppassword -e "DROP DATABASE IF EXISTS create_table_test" }
  system %{ mysql -u root -ppassword -e "CREATE DATABASE create_table_test CHARSET utf8" }
  ENV['DATABASE_URL'] = 'mysql2://root:password@127.0.0.1/create_table_test'
  ActiveRecord::Base.establish_connection
when 'sqlite3'
  ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ':memory:'
else
  raise "not supported"
end

require 'create_table'

module SpecHelper
  def assert_same_sql(ref, actual)
    ref = [ref].flatten
    actual = [actual].flatten

    ref.each_with_index do |ref1, i|
      clean_sql(actual[i]).should == clean_sql(ref1)
    end
  end

  def assert_same_result(table_name, a, b)
    conn = ActiveRecord::Base.connection
    
    [a].flatten.each { |stmt| conn.execute stmt }
    a_columns = conn.columns table_name
    a_indexes = conn.indexes table_name
    conn.drop_table table_name
    
    [b].flatten.each { |stmt| conn.execute stmt }
    b_columns = conn.columns table_name
    b_indexes = conn.indexes table_name
    conn.drop_table table_name
    
    [:name, :sql_type, :default].each do |variable|
      b_columns.map(&variable).should == a_columns.map(&variable)
    end
    a_indexes.should == b_indexes
  end

  private
  def clean_sql(sql)
    sql.gsub('`', '"').gsub(/\s+/, ' ').gsub(/\s*([,\(\)])\s*/, '\1').strip
  end
end

RSpec.configure do |c|
  c.include SpecHelper
end