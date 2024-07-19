def draw_screen(obstacles)

    move_cursor(1, 1)
    font_color(DEFAULT)

    obstacles.each do | obstacle |

        obstacle.positions.each do | position |
           
            move_cursor(position.y, position.x)
            font_color(obstacle.color)
            print obstacle.symbol

        end
    end

end