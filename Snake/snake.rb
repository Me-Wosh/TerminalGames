require "./position.rb"
require "../colors.rb"

class Snake
    # UP DOWN LEFT RIGHT
    attr_accessor :direction
    attr_reader :bodies_positions, :head, :speed, :symbol, :color

    def initialize(row, column)
        @bodies_positions = [Position.new(row, column)]
        @head = @bodies_positions.first
        
        @direction = "UP"

        # in seconds (after what time the snake will move again)
        @speed = 0.15
        
        @symbol = "&"

        @color = WHITE
    end

    def move()
        (@bodies_positions.length - 1).downto(1) do | i |
            previous_body = @bodies_positions[i - 1]
            @bodies_positions[i] = Position.new(previous_body.y, previous_body.x)
        end

        case @direction
            # update snake head
            when "UP"
                @head.y -= 1
            when "DOWN"
                @head.y += 1
            when "RIGHT"
                @head.x += 1
            when "LEFT"
                @head.x -= 1
        end
    end

    def grow(tail)
        @bodies_positions.append(Position.new(tail.y, tail.x))
    end
end