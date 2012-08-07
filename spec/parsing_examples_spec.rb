require 'spec_helper'
require 'yaml'

describe 'Parsing examples' do
  Dir[File.expand_path('../parsing_examples/*.yml', __FILE__)].each do |path|
    e = YAML.load_file(path)
    describe e.fetch('name', path) do
      before do
        @c = CreateTable.new(e['sql'])
      end
      e.each do |k, ref|
        next if ['name', 'sql'].include?(k)
        it "checks #{k}" do
          calc = if k.include?('.')
            eval(%{@c.#{k}})
          else
            @c.send(k)
          end
          calc.should == ref
        end
      end
    end
  end
end