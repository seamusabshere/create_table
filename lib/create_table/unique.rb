class CreateTable
  class Unique < Index
    def unique
      true
    end
  end
end
