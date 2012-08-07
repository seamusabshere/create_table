class CreateTable
  class Column
    attr_reader :parent
    attr_reader :name

    attr_accessor :options
    
    def initialize(parent, name, options = nil)
      @parent = parent
      @name = name
      @options = options
    end

    def to_sql
      [name, options].join ' '
    end
  end
end
