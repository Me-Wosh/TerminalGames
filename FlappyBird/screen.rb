def draw_screen(bird, obstacles, points)

    move_cursor(1, 1)

    ROWS.times do | row |
        COLUMNS.times do
            print "*"
        end

        if row < ROWS - 1
            cursor_next_line_beggining(1)
        end
    end

    move_cursor(bird.position.y, bird.position.x)
    background_color(bird.color)
    print " "

    obstacles.each do | obstacle |

        obstacle.positions.each do | position |
           
            move_cursor(position.y, position.x)
            background_color(obstacle.color)
            print " "

        end
    end

    move_cursor(ROWS / 4, (COLUMNS / 2).ceil())
    background_color(BLACK_BACKGROUND)
    font_color(WHITE)
    print points

end