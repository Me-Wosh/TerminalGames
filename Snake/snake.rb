require "./directions.rb"
require "./game_modes.rb"
require "./position.rb"
require "../colors.rb"

class Snake
    @new_body_position = nil
    @game_mode = nil
    @one_percent_delay = nil
    @one_percent_positions = nil
    attr_reader :bodies_positions, :head, :direction, :initial_delay, :delay, :head_symbol, :bodies_symbol, :color

    def initialize(row, column, game_mode, available_positions)
        @bodies_positions = [Position.new(row, column)]
        @head = @bodies_positions.first
        # position where new body segment after growth will be placed
        @new_body_position = Position.new(@bodies_positions.last.y, @bodies_positions.last.x)
        
        @direction = RIGHT

        @game_mode = game_mode

        # after what time the snake will move again (in seconds)
        proposed_delay = 100.0 / available_positions
        
        if proposed_delay < 0.08
            @initial_delay = 0.08
        elsif proposed_delay > 0.35
            @initial_delay = 0.35
        else
            @initial_delay = proposed_delay
        end

        @delay = @initial_delay

        if @game_mode == SPEED
            @one_percent_delay = 0.01 * @delay
            @one_percent_positions = 0.01 * available_positions

            # if food needed to speed up is less than one, calculate how much faster (instead of 1% faster)
            # the snake needs to become after eating 1 food
            if 1 / @one_percent_positions > 1
                @one_percent_delay *= 1 / @one_percent_positions
            end

            @one_percent_positions = @one_percent_positions.ceil()
        end

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

        if @game_mode == SPEED && @bodies_positions.length % @one_percent_positions == 0 && @delay >= 2 * @one_percent_delay
            @delay -= @one_percent_delay
        end
    end
end