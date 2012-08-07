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

    def quoted_name
      CreateTable.quote_ident name
    end

    def to_sql
      [quoted_name, options].join ' '
    end
  end
end
