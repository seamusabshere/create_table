Before do
  @create_table = CreateTable.new
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

Then /(.*) should be (.*)/ do |method_id, ref|
  case ref
  when /^"/
    ref = ref[1..-2]
  when 'nil'
    ref = nil
  when 'false'
    ref = false
  when 'true'
    ref = true
  end

  v = @object.send(method_id)
  case v
  when Array
    v = v.join(', ')
  end

  v.should == ref
end
