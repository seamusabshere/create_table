class CreateTable
  class Index
    attr_reader :parent
    attr_accessor :column_name
    attr_accessor :name
    
    def initialize(parent, column_name = nil, name = nil)
      @parent = parent
      @column_name = column_name
      @name = name
    end
  end
end
