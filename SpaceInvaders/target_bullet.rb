require "./bullet.rb"

class TargetBullet < Bullet
    def symbol
        return @symbol = "|"
    end

    def move
        @position[0] += 1
    end
end