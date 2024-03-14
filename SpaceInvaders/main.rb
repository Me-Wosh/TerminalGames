require "../terminal_commands.rb"
require "./screen.rb"
require "./target.rb"
require "./player.rb"

ROWS = 20
COLUMNS = 42

$ticks = 0
$speed = 62

if __FILE__ == $0

    hide_key_input
    set_title("Space Invaders")
    set_terminal_size(ROWS, COLUMNS)
    set_screen_size(ROWS, COLUMNS)
    move_cursor(1, 1)
    clear_screen
    hide_cursor

    Player.position = [ROWS, COLUMNS / 2]
    
    while true

        $ticks += 1

        if Target.targets.any? == false
            $ticks = 0

            Target.generate_targets(3, 3, ROWS, COLUMNS)
            
            if $speed >= 2
                $speed -=2
            end
        end

        if $ticks % $speed == 0    
            Target.move_targets(ROWS, COLUMNS)
            clear_screen
        end

        if $ticks % 3 == 0 and Player.bullet_position
            Player.move_bullet
            clear_screen
        end

        read_key
        draw_screen
        move_cursor(1,1)
        
    end

    show_key_input

end