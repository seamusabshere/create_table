require 'spec_helper'
require 'yaml'

describe CreateTable do
  Dir[File.expand_path('../generating/*.yml', __FILE__)].each do |path|
    describe "using #{File.basename(path)}" do
      src = YAML.load_file path

      %w{ postgresql mysql sqlite3 }.permutation(2).each do |db1, db2|
        it "parses #{db1}-compatible SQL to generate #{db2}-compatible SQL" do
          [ src['input'][db1] ].flatten(1).compact.each do |sql|
            c = CreateTable.new sql
            assert_same_sql src['output'][db2], c.send("to_#{db2}")
          end
        end
      end

      [ src['input'][ENV['DB']] ].flatten(1).compact.each_with_index do |sql, i|
        it "generates #{ENV['DB']}-compatible SQL that is functionally equivalent to original (#{i})" do
          c = CreateTable.new sql
          assert_same_result src['table_name'], sql, c.send("to_#{ENV['DB']}")
        end
      end
    
    end
  end
end
