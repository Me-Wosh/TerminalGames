require "../terminal_commands.rb"
require "io/console"
require "./screen.rb"
require "./target.rb"
require "./player.rb"
require "./shield.rb"
require "./player_bullet.rb"
require "./target_bullet.rb"

ROWS = 20
COLUMNS = 42

$game_loop = true
$score = 0
$ticks = 0
$speed = 260
$targets = []
$shields = []
$all_targets_count = 0
$targets_direction = "right"

def player_hit
    if $target_bullet and $target_bullet.position == Player.position
        return true
    else
        return false
    end
end

if __FILE__ == $0

    initial_size = get_terminal_size
    hide_key_input
    set_title("Space Invaders")
    set_terminal_size(ROWS, COLUMNS)
    move_cursor(1, 1)
    clear_screen
    hide_cursor

    Player.position = [ROWS - 1, COLUMNS / 2]

    while $game_loop

        $ticks += 1

        if not $targets.any?
            $ticks = 0
            $target_bullet = nil
            $player_bullet = nil

            $targets = Target.generate_targets(3, 3, ROWS, COLUMNS)
            $all_targets_count = $targets.length

            $shields = Shield.generate_shields_field(Player.position[0], 2)

            if $speed >= 100
                $speed -= 4
            end
        end

        if $targets.last and $targets.last.position[0] >= Player.position[0]
            $game_loop = false
        end

        if player_hit
            if Player.health > 1 
                Player.health -= 1
                sleep(3)
            
            else
                $game_loop = false
            end
        end

        if not $target_bullet and not $ticks_target
            $ticks_target = $ticks + 160 + ($all_targets_count - $targets.length) * 2
        end

        if $ticks == $ticks_target
            $target_bullet = TargetBullet.new
            random_position = Target.get_random_target_position($targets)
            $target_bullet.shoot(random_position[0], random_position[1])

            $ticks_target = nil
        end

        if $target_bullet and $target_bullet.position[0] >= ROWS - 1
            $target_bullet = nil
        end

        if $ticks % $speed == 0    

            case $targets_direction
        
            when "right"
        
                if $targets.any? { |target| target.position[1] >= COLUMNS }
                    $targets.each do |target|
                        target.position[0] += 1
                    end
                    
                    $targets_direction = "left"
                else
                    $targets.each do |target|
                        target.position[1] += 1
                    end
                end
        
            when "left"
                
                if $targets.any? { |target| target.position[1] <= 1 }
                    $targets.each do |target|
                        target.position[0] += 1
                    end
                
                    $targets_direction = "right"
                else
                    $targets.each do |target|
                        target.position[1] -= 1
                    end
                end

            end
            
            clear_screen
        end

        if $player_bullet and $ticks % 10 == 0
            $player_bullet.move
            clear_screen
        end

        if $target_bullet and $ticks % 60 == 0
            $target_bullet.move
            clear_screen
        end


        key = STDIN.read_nonblock(1) rescue nil
        
        case key
            when 'q'
                $game_loop = false
        
            when 'C' # right arrow
                if not Player.position[1] >= COLUMNS
                    Player.move_right
                    clear_screen
                end
        
            when 'D' # left arrow
                if not Player.position[1] <= 1
                    Player.move_left
                    clear_screen
                end
        
            when ' ' # spacebar
                if not $player_bullet
                    $player_bullet = PlayerBullet.new
                    $player_bullet.shoot(Player.position[0] - 1, Player.position[1])
                end
        end
    
        
        draw_screen
        move_cursor(1,1)
        
    end

    set_terminal_size(initial_size[0], initial_size[1])
    clear_screen
    move_cursor(1, 1)
    print "Game Over, Score: #{$score}"
    show_key_input
    font_color(DEFAULT)

end