class CreateTable
  class Column
    class ToSql
      def quoted_name
        CreateTable.quote_ident name
      end

      def to_sql(format = :postgresql)
        [quoted_name, data_type(format), options].join ' '
      end

      def options
        parts = []
        if primary_key
          parts << 'PRIMARY KEY'
        end
        if unique and not named_unique
          parts << 'UNIQUE'
        end
        if autoincrement
          parts << 'AUTO_INCREMENT'
        end
        parts.join ' '
      end

    end
  end
end