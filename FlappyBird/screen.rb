def draw_screen(bird, obstacles)

    move_cursor(1, 1)
    font_color(DEFAULT)

    move_cursor(bird.position.y, bird.position.x)
    font_color(bird.color)
    print bird.symbol

    obstacles.each do | obstacle |

        obstacle.positions.each do | position |
           
            move_cursor(position.y, position.x)
            font_color(obstacle.color)
            print obstacle.symbol

        end
    end

end