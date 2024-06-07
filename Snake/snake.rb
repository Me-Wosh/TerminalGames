require "./position.rb"

class Snake
    # UP DOWN LEFT RIGHT
    attr_accessor :direction
    attr_reader :bodies_positions, :speed, :symbol

    def initialize(row, column)
        @direction = "UP"

        # in seconds
        @speed = 0.5
        
        @symbol = "*"

        @bodies_positions = [Position.new(row, column)]
    end

    def move()
        case @direction
            # update snake head
            when "UP"
                @bodies_positions.first.y -= 1
            when "DOWN"
                @bodies_positions.first.y += 1
            when "RIGHT"
                @bodies_positions.first.x += 1
            when "LEFT"
                @bodies_positions.first.x -= 1
        end
    end
end