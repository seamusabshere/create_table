Before do
  @create_table = CreateTable.new
end

Given /CREATE TABLE sql/ do |sql|
  @object = CreateTable.new sql
end

Given /column definition (.*)/ do |str|
  @object = CreateTable::Column.new(@create_table).parse(str)
end

Given /index definition (.*)/ do |str|
  @object = CreateTable::Index.new(@create_table).parse(str)
end

Given /unique definition (.*)/ do |str|
  @object = CreateTable::Unique.new(@create_table).parse(str)
end

def fix_ref(ref)
  case ref
  when /^"/
    ref[1..-2]
  when 'nil'
    nil
  when 'false'
    false
  when 'true'
    true
  when /^\d+$/
    ref.to_i
  else
    ref
  end
end

def fix_v(v)
  case v
  when Array
    v.join(', ')
  else
    v
  end
end

Then /the (.*) should be (.*)/ do |method_id, ref|
  ref = fix_ref ref
  v = @object.send(method_id)
  v = fix_v v
  v.should == ref
end

Then /column (.*) (.*) should be (.*)/ do |column_name, method_id, ref|
  ref = fix_ref ref
  column_name = fix_ref column_name
  v = @object.columns[column_name].send(method_id)
  v = fix_v v
  v.should == ref
end
