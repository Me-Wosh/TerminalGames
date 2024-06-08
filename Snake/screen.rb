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
        print snake.symbol
    end
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
        if i == 1 or COLUMNS < get_terminal_size().last
            cursor_left(1)
        end
        
        (ROWS - 4).times do
            print "|"
            cursor_down(1)

            if i == 1 or COLUMNS < get_terminal_size().last
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