require "./bullet.rb"

class PlayerBullet < Bullet
    def move
        @position[0] -= 1
    end
end