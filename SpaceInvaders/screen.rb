require "../terminal_commands.rb"
require "../colors.rb"
require "io/console"
require "./target.rb"
require "./player.rb"

$score = 0
$rows = 0
$columns = 0

def set_screen_size(rows, columns)
    $rows = rows
    $columns = columns
end

def draw_screen

    if Player.bullet_position and Player.bullet_position[0] <= 1 # top barrier
        Player.bullet_position = nil
    end

    for row in (1..$rows)

        if row == 1
            print "Score: #{$score}"
        end

        for column in (1..$columns)

            if Player.bullet_position and Target.targets.any? { |target| target.position == Player.bullet_position }
                index = Target.targets.index { |target| target.position == Player.bullet_position }
                Target.targets.delete_at(index)
                Player.bullet_position = nil
                $score += 1

            elsif Target.targets.any? { |target| target.position == [row, column]}
                print Target.symbol

            elsif Player.position == [row, column]
                set_color(Player.color)
                print Player.symbol
                set_color(DEFAULT)

            elsif Player.bullet_position == [row, column]
                set_color(Player.bullet_color)
                print Player.bullet_symbol
                set_color(DEFAULT)

            else
                cursor_right(1)
            end
        end
        
        if not row == $rows
            cursor_next_line_beggining(1)
        end

    end

    cursor_current_line_beggining

end

def game_over
    clear_screen
    move_cursor(1, 1)
    print "Game Over, Score: #{$score}"
    exit
end


def read_key
    
    key = STDIN.read_nonblock(1) rescue nil
        
    case key
    when 'q'
        exit

    when 'C' # right arrow
        if not Player.position[1] >= $columns 
            Player.move_right
            clear_screen
        end

    when 'D' # left arrow
        if not Player.position[1] <= 1
            Player.move_left
            clear_screen
        end

    when ' ' # spacebar
        Player.shoot
    end

end