require 'spec_helper'
require 'yaml'

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
    end
  end
end