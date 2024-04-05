class Bullet
    def shoot(row, column)
        @position = [row, column]
    end

    def position
        return @position
    end

    def symbol
        return @symbol = "."
    end
end