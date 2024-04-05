require "../colors.rb"

class Shield
   
    def initialize(row, column)
        @position = [row, column]
        @health = 3
    end

    def position
        return @position
    end
    
    def health
        return @health
    end

    def health=(value)
        @health = value
    end

    def color
        return @color = GREEN
    end

    def self.generate_shields_field(player_row, height)

        shields = []
        start_row = player_row - height - 1

        for row in (start_row...(start_row + height))
            counter = 0

            for column in (4..(COLUMNS - 2))
                
                if counter >= 4 and counter <= 6
                    counter += 1
                    next
                end

                if counter == 7
                    counter = 0
                    next
                end

                shield = new(row, column)
                shields.append(shield)
                counter += 1
            end
        end

        return shields
        
    end

end