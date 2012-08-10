class CreateTable
  class Unique < Index
    def unique
      true
    end

    # won't ever be written
    def to_sql
      if name
        super
      end
    end
  end
end
