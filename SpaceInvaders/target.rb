class Target
    def initialize(rows, columns)
        @position = [rows, columns]
        @symbol = '*'
    end

    def position
        return @position
    end

    def symbol
        return @symbol
    end
end