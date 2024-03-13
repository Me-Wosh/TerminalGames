class Player
    @@symbol = "\u00dc"
    @@position = [20, 21]  

    def self.position
        return @@position
    end

    def self.symbol
        return @@symbol
    end

    def self.move_left
        position[1] -= 1
    end

    def self.move_right
        position[1] += 1
    end
end