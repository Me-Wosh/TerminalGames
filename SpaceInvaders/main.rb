require "../terminal_commands.rb"
require "./screen.rb"
require "./target.rb"
require "./player.rb"

ROWS = 20
COLUMNS = 42

ticks = 0

if __FILE__ == $0

    hide_key_input
    set_title("Space Invaders")
    set_size(ROWS, COLUMNS)
    move_cursor(1, 1)
    clear_screen
    hide_cursor

    Target.generate_targets(3, 3, ROWS, COLUMNS)
    
    while true

        ticks += 1

        if (ticks % 60 == 0)
            Target.move_targets(ROWS, COLUMNS)
            clear_screen
        end

        read_key

        move_cursor(1,1)
        draw_screen(ROWS, COLUMNS)
        
    end

    show_key_input

end