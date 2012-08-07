require 'spec_helper'
require 'yaml'
require 'active_record'

system %{ mysql -u root -ppassword -e "DROP DATABASE IF EXISTS create_table_test; CREATE DATABASE create_table_test CHARSET utf8" }
ENV['DATABASE_URL'] ||= 'mysql2://root:password@127.0.0.1/create_table_test'
ActiveRecord::Base.establish_connection

describe 'Examples' do
  Dir[File.expand_path('../examples/*.yml', __FILE__)].each do |path|
    e = YAML.load_file(path)
    describe e.fetch('name', path) do
      before do
        @c = CreateTable.new(e['input'])
      end

      it "generates correct output" do
        assert_same_sql @c.to_sql, e['output']
      end

      e.each do |k, ref|
        next if ['name', 'input', 'output'].include?(k)
        it "checks #{k}" do
          calc = if k.include?('.')
            eval(%{@c.#{k}})
          else
            @c.send(k)
          end
          calc.should == ref
        end
      end

      it "compares favorably with ActiveRecord's interpretation" do
        conn = ActiveRecord::Base.connection
        conn.execute e['input']
        @c.columns.map(&:name).should == conn.columns(e['table_name']).map(&:name)
        conn.drop_table e['table_name']
      end
    end
  end
end