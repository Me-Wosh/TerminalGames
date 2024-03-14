require "../colors.rb"

class Player
    @@bullet_position = nil
    
    def self.position
        return @@position
    end

    def self.position=(position)
        @@position = position
    end

    def self.symbol
        return @@symbol = "\u00dc"
    end

    def self.color
        return @@color = GREEN
    end

    def self.bullet_color
        return @@bullet_color = GREEN
    end

    def self.move_left
        @@position[1] -= 1
    end

    def self.move_right
        @@position[1] += 1
    end

    def self.bullet_position
        return @@bullet_position
    end

    def self.bullet_position=(position)
        @@bullet_position = position
    end

    def self.shoot
        if @@bullet_position
            return
        end

        @@bullet_position = [@@position[0] - 1, @@position[1]]
    end

    def self.move_bullet
        @@bullet_position[0] -= 1
    end

    def self.bullet_symbol
        return bullet = "."
    end
end