require "../colors.rb"

class Food
    attr_reader :available_positions, :position, :symbol, :color
    
    def initialize(available_positions)
        @available_positions = available_positions
        @symbol = "*"
        @color = random_color()
        spawn()
    end

    private

    def spawn()
        random_index = Random.rand(@available_positions.length)
        @position = @available_positions[random_index]
    end

    def random_color()
        colors = [RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN]
        random_index = Random.rand(colors.length)

        return colors[random_index]
    end
end