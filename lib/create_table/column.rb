class CreateTable
  class Column
    attr_reader :parent
    attr_reader :name

    attr_accessor :options
    
    def initialize(parent, name)
      @parent = parent
      @name = name
    end
  end
end
