class CreateTable
  class Column
    KEYWORDS = {
      :autoincrement => /auto_?increment/i, # THIS SHOULD BE REMOVED
      :primary_key   => /primary(?: key)?/i, # THIS SHOUlDN'T
      :unique        => /unique/i,
    }

    attr_reader :parent
    attr_reader :name
    attr_reader :autoincrement

    attr_reader :options

    def initialize(parent, name, options = nil)
      @parent = parent
      @name = name
      self.options = options
    end

    def quoted_name
      CreateTable.quote_ident name
    end

    def compatible_options
      parts = []
      parts << options
      if primary_key
        parts << 'PRIMARY KEY'
      elsif unique
        parts << 'UNIQUE'
      end
      if autoincrement
        parts << 'AUTO_INCREMENT'
      end
      parts.join ' '
    end

    def to_sql
      [quoted_name, compatible_options].join ' '
    end
    
    def primary_key
      if pk = parent.primary_key
        pk.column_name == name
      end
    end

    def primary_key!
      parent.primary_key = name
    end

    def unique!
      parent.add_unique name
    end

    def unique
      parent.uniques.map(&:column_name).include? name
    end

    def autoincrement!
      @autoincrement = true
    end

    def options=(str)
      return unless str
      memo = str.dup
      KEYWORDS.each do |k, v|
        if memo =~ v
          send "#{k}!"
          memo.gsub! v, ''
        end
      end
      memo.gsub! /\s+/, ' '
      memo.strip!
      @options = memo
    end
  end
end
