class Position
    attr_accessor :x
    attr_accessor :y

    def initialize(row, column)
        @x = column
        @y = row
    end
end