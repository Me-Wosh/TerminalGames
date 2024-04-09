class Target

    def initialize(row, column, color)
        @position = [row, column]
        @color = color
    end

    def position
        return @position
    end

    def symbol
        return @symbol = "*"
    end

    def color
        return @color
    end
end