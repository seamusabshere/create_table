require 'bundler/setup'

require 'create_table'

module SpecHelper
  def assert_same_sql(a, b)
    clean_sql(a).should == clean_sql(b)
  end
  private
  def clean_sql(sql)
    sql.gsub(/\s+/, ' ').gsub(' ,', ',').strip
  end
end

RSpec.configure do |c|
  c.include SpecHelper
end