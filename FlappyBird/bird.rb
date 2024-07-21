class Bird

    attr_reader :color, :symbol
    attr_accessor :position, :previous_position, :free_fall_start, :free_fall_initial_height

    def initialize()
        @color = YELLOW
        @symbol = '@'
        @position = @previous_position = Position.new(ROWS / 2, COLUMNS / 2)
        @free_fall_start = Time.now()
        @free_fall_initial_height = @position.y
    end

    def fly_upwards()
        @position.y -= 1
        @free_fall_start = Time.now()
        @free_fall_initial_height = @position.y
    end

end