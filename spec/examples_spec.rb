require 'spec_helper'
require 'yaml'

to_sql_method = case ActiveRecord::Base.connection.adapter_name
when /sqlite/i
  'to_sqlite3'
when /postgr/i
  'to_postgresql'
when /mysql/i
  'to_mysql'
else
  raise "can't"
end

describe 'Examples' do
  Dir[File.expand_path('../examples/*.yml', __FILE__)].each do |path|
    describe path do
      src = YAML.load_file(path)
      [src['_input']].flatten.each_with_index do |input, idx|
        c = CreateTable.new input
        describe "Input #{idx}" do
          src.each do |k, ref|
            next if k.start_with?('_')
            it "checks #{k}" do
              case k
              when /\W/
                eval(%{c.#{k}}).should == ref
              when /^to_.*sql/
                assert_same_sql c.send(k), ref
              else
                c.send(k).should == ref
              end
            end
          end
          it "is functionally equivalent" do
            assert_same_result src['table_name'], input, src[to_sql_method] # more of a sanity check
            assert_same_result src['table_name'], input, c.send(to_sql_method)
          end
        end
      end
    end
  end
end
