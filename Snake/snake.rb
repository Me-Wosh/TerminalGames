require "./directions.rb"
require "./game_modes.rb"
require "./position.rb"
require "../colors.rb"

class Snake
    @new_body_position = nil
    @game_mode = nil
    attr_reader :bodies_positions, :head, :direction, :delay, :head_symbol, :bodies_symbol, :color

    def initialize(row, column, game_mode, available_positions)
        @bodies_positions = [Position.new(row, column)]
        @head = @bodies_positions.first
        # position where new body segment after growth will be placed
        @new_body_position = Position.new(@bodies_positions.last.y, @bodies_positions.last.x)
        
        @direction = UP

        @game_mode = game_mode

        # in seconds (after what time the snake will move again)
        @delay = available_positions / (available_positions * 6.66)
        
        @head_symbol = "&"
        @bodies_symbol = "#"

        @color = WHITE
    end

    def direction=(direction)
        case direction
            when UP
                if @direction != DOWN || @bodies_positions.length == 1
                    @direction = UP
                end
            when DOWN
                if @direction != UP || @bodies_positions.length == 1
                    @direction = DOWN
                end
            when RIGHT
                if @direction != LEFT || @bodies_positions.length == 1
                    @direction = RIGHT
                end
            when LEFT
                if @direction != RIGHT || @bodies_positions.length == 1
                    @direction = LEFT
                end
        end
    end

    def move()
        @new_body_position = Position.new(@bodies_positions.last.y, @bodies_positions.last.x)

        (@bodies_positions.length - 1).downto(1) do | i |
            previous_body = @bodies_positions[i - 1]
            @bodies_positions[i] = Position.new(previous_body.y, previous_body.x)
        end

        case @direction
            when UP
                @head.y -= 1
            when DOWN
                @head.y += 1
            when RIGHT
                @head.x += 1
            when LEFT
                @head.x -= 1
        end
    end

    def grow()
        @bodies_positions.append(Position.new(@new_body_position.y, @new_body_position.x))

        if @game_mode == SPEED && delay >= 0.02
            @delay -= 0.01
        end
    end
end