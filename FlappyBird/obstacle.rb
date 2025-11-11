class Obstacle

    GAP_SIZE = 3
    attr_reader :positions, :color

    def initialize()

        @positions = []
        @color = GREEN_BACKGROUND

        spawn()
    end

    def self.spawn_delay
        # in seconds
        return 1.5
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