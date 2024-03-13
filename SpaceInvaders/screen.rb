require "../terminal_commands.rb"
require "io/console"
require "./target.rb"
require "./player.rb"

def draw_screen(rows, columns)

    for row in (1..rows)
        for column in (1..columns)
            if Target.targets.any? { |target| target.position == [row, column]}
                print Target.symbol
            elsif Player.position == [row, column]
                print Player.symbol
            else
                cursor_right(1)
            end
        end
        
        if not row == rows
            cursor_next_line_beggining(1)
        end
    end

    cursor_current_line_beggining

end


def read_key
    
    key = STDIN.read_nonblock(1) rescue nil
        
    case key
    when 'q'
        exit

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
    end

end