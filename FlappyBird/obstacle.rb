class Obstacle

    GAP_SIZE = 4
    attr_reader :positions, :color, :symbol

    def initialize()

        @positions = []
        @color = GREEN
        @symbol = "#"

        spawn()
    end

    def self.spawn_delay
        # in seconds
        return 2
    end

    def self.move_delay
        # in seconds
        return 0.1
    end

    def move()
        @positions.each do | position |
            position.x -= 1
        end
    end

    def touched_barrier()
        return @positions.first.x <= 1
    end

    private

    def spawn()

        gap_start = Random.rand(2...ROWS - GAP_SIZE)

        1.upto(ROWS) do | row |

            if row < gap_start || row > gap_start + GAP_SIZE
                @positions.append(Position.new(row, COLUMNS))
            end

        end

    end

end