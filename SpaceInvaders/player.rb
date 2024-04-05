require "../colors.rb"

class Player
    @@health = 3
    @@max_health = 3
    
    def self.position
        return @@position
    end

    def self.position=(position)
        @@position = position
    end

    def self.health
        return @@health
    end

    def self.health=(value)
        @@health = value
    end

    def self.max_health
        return @@max_health
    end

    def self.symbol
        return @@symbol = "\u00dc"
    end

    def self.color
        return @@color = GREEN
    end

    def self.move_left
        @@position[1] -= 1
    end

    def self.move_right
        @@position[1] += 1
    end

end