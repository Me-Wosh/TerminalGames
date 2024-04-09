class Bullet
    def shoot(row, column)
        @position = [row, column]
        @symbol = "."
    end

    def position
        return @position
    end

    def symbol
        return @symbol
    end

    def symbol=(value)
        @symbol = value
    end
end