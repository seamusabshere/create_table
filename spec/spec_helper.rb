require 'bundler/setup'

Bundler.with_clean_env do
  system %{rake ragel}
  raise RuntimeError unless $?.success?
end

require 'active_record'

system %{ mysql -u root -ppassword -e "DROP DATABASE IF EXISTS create_table_test" }
system %{ mysql -u root -ppassword -e "CREATE DATABASE create_table_test CHARSET utf8" }
ENV['DATABASE_URL'] ||= 'mysql2://root:password@127.0.0.1/create_table_test'
ActiveRecord::Base.establish_connection

require 'create_table'

module SpecHelper
  def assert_same_sql(a, b)
    a = [a].flatten
    b = [b].flatten
    
    a.each_with_index do |aa, i|
      # $stderr.puts "#{a.inspect} versus #{b[i].inspect}"
      clean_sql(aa).should == clean_sql(b[i])
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