require 'delegate'
class CreateTable
  class ColumnNameBasedCollection < Delegator
    class << self
      def create
        new([])
      end
    end

    def __getobj__
      @items
    end

    def __setobj__(items)
      @items = items
    end

    def [](column_names)
      return if column_names.nil?
      k = [column_names].flatten
      retval = @items.select { |i| i.column_names == k }
      raise "oops #{k.inspect}: #{retval.map(&:column_names).inspect}" if retval.length > 1
      retval.first
    end
  end
end