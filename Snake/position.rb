class Position
    attr_accessor :x, :y

    def initialize(row, column)
        @x = column
        @y = row
    end

    def ==(second_position)
        return second_position.x == @x && second_position.y == @y
    end
end