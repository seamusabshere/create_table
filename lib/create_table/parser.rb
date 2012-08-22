class CreateTable
  module Parser
    def Parser.remove_comments(str)
      str.gsub SQL_COMMENT, ''
    end

    # http://ostermiller.org/findcomment.html
    SQL_COMMENT = %r{/\*(?:.|[\r\n])*?\*/}m

    def read(data, s, p)
        data[s...p].pack('c*')
    end

    # you still have to put this in the body of your file
    # def parse(str)
    #   data = Parser.remove_comments(str).unpack('c*')
    #   %% write data;
    #   # % (this fixes syntax highlighting)
    #   parens = 0
    #   p = item = 0
    #   pe = eof = data.length
    #   %% write init;
    #   # % (this fixes syntax highlighting)
    #   %% write exec;
    #   # % (this fixes syntax highlighting)
    # end
  end
end
