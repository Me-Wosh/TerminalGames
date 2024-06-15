require "./food.rb"
require "./snake.rb"
require "../colors.rb"
require "../terminal_commands.rb"

def draw_screen(snake, food)
    move_cursor(1, 1)
    font_color(WHITE)
    draw_borders()
    draw_score()

    if food != nil
        move_cursor(food.position.y, food.position.x)
        font_color(food.color)
        print food.symbol
    end

    snake.bodies_positions.each do | position |
        move_cursor(position.y, position.x)
        font_color(snake.color)

        if position == snake.head
            print snake.head_symbol
        else
            print snake.bodies_symbol
        end
    end
end

def main_menu(option)
    middle_row = ROWS / 2
    middle_column = COLUMNS / 2
    
    menu_message = "Menu"

    move_cursor(middle_row - 2, middle_column - menu_message.length / 2)
    print menu_message

    options = ["classic snake", "speed snake", "quit"]
    longest_option = options.max() { | i, j | i.length <=> j.length }

    3.times do | i |
        move_cursor(middle_row + i, middle_column - longest_option.length / 2 + 2)
        print options[i]
    end

    move_cursor(middle_row + option, middle_column - longest_option.length / 2)
    print ">"
end

def game_over(row)
    clear_screen()
    move_cursor(row, 1)
    print "Game over, score: #{$score}"
end

def game_won(row)
    clear_screen()
    move_cursor(row, 1)
    print "Congratulations you scored maximum points, score: #{$score}"
end

def draw_borders()
    draw_corners()
    draw_vertical_borders()
    draw_horizontal_borders()
end

def draw_score()
    move_cursor(2, 2)
    print "Score: #{$score}"
end

def draw_corners()
    # left top corner
    move_cursor(1, 1)
    print "+"

    # right top corner
    move_cursor(1, COLUMNS)
    print "+"

    # board left top corner
    move_cursor(3, 1)
    print "+"

    # board right top corner
    move_cursor(3, COLUMNS)
    print "+"

    # left bottom corner
    move_cursor(ROWS, 1)
    print "+"

    # right bottom corner
    move_cursor(ROWS, COLUMNS)
    print "+"
end

def draw_vertical_borders()
    for i in (1..2)
        case i
            when 1
                move_cursor(2, 1)
            when 2
                move_cursor(2, COLUMNS)
        end

        print "|"
        cursor_down(2)

        # printing a character moves cursor one column to the right, therefore it is necessary to revert 
        # this prcoess by moving the cursor one column to the left in order to go straight down
        # this doesnt apply if terminal did resize correctly and it is the last column of the terminal
        if i == 1 || COLUMNS < get_terminal_size().last
            cursor_left(1)
        end
        
        (ROWS - 4).times do
            print "|"
            cursor_down(1)

            if i == 1 || COLUMNS < get_terminal_size().last
                cursor_left(1)
            end
        end
    end
end

def draw_horizontal_borders()
    for i in (1..3)
        case i
            when 1
                move_cursor(1, 2)
            when 2
                move_cursor(3, 2)
            when 3
                move_cursor(ROWS, 2)
        end

        (COLUMNS - 2).times do
            print "-"
        end
    end
end