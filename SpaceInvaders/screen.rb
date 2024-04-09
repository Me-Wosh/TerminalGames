def draw_screen

    shields_starting_row = 0
    shields_ending_row = 0
    targets_starting_row = 0
    targets_ending_row = 0    

    if $shields.any?
        shields_starting_row = $shields.first.position[0]
        shields_ending_row = $shields.last.position[0]
    end

    if $targets.any?
        targets_starting_row = $targets.first.position[0]
        targets_ending_row = $targets.last.position[0]
    end

    for row in (1..ROWS)

        if row == 1
            font_color(WHITE)
            print "Score: #{$score}"
            
            move_cursor(row, COLUMNS / 2)
            print "Level: #{$level}"
        end

        if row == ROWS
            font_color(WHITE)
            print "#{Player.health} "
            
            Player.health.times do
                font_color(Player.color)
                print "#{Player.symbol} "
            end
        end

        for column in (1..COLUMNS)

            if row >= targets_starting_row and row <= targets_ending_row and target_index = $targets.index { |target| target.position == [row, column] }

                if $player_bullet and $targets[target_index].position == $player_bullet.position
                    $targets.delete_at(target_index)
                    $player_bullet = nil
                    $score += 1
                    cursor_right (1)

                elsif shield_index = $shields.index { |shield| shield.position == [row, column] }
                    $shields.delete_at(shield_index)
                    cursor_right(1)

                else
                    font_color($targets[target_index].color)
                    print $targets[target_index].symbol
                end

            elsif $special_target and $special_target.position == [row, column]

                if $player_bullet and $special_target.position == $player_bullet.position
                    $score += 10
                    $special_target = nil
                    $player_bullet = nil
                    cursor_right(1)
                else
                    font_color($special_target.color)
                    print $special_target.symbol
                end

            elsif row <= shields_ending_row and row >= shields_starting_row and shield_index = $shields.index { |shield| shield.position == [row, column] }
                
                if $target_bullet and $target_bullet.position == $shields[shield_index].position

                    $target_bullet = nil
                    cursor_right(1)

                    if $shields[shield_index].health > 1
                        $shields[shield_index].health -= 1
                    else
                        $shields.delete_at(shield_index)
                    end

                elsif $player_bullet and $player_bullet.position == $shields[shield_index].position
                    
                    $player_bullet = nil
                    cursor_right(1)

                    if $shields[shield_index].health > 1
                        $shields[shield_index].health -= 1
                    else
                        $shields.delete_at(shield_index)
                    end

                else
                    font_color($shields[shield_index].color)
                    print $shields[shield_index].health
                end

            elsif $player_bullet and $player_bullet.position == [row, column]
                font_color(Player.color)
                print $player_bullet.symbol

            elsif Player.position == [row, column]
                font_color(Player.color)
                print Player.symbol

            elsif $target_bullet and $target_bullet.position == [row, column]
                font_color(WHITE)
                print $target_bullet.symbol

            else
                cursor_right(1)
            end
        end
        
        if row < ROWS
            cursor_next_line_beggining(1)
        end

        font_color(WHITE)

    end

    cursor_current_line_beggining

end

def next_level_animation

    font_color(WHITE)

    for row in (1..ROWS)
        for column in (1..COLUMNS / 2)
            print "=="
            sleep(0.01)
        end
    end

    clear_screen
    move_cursor(ROWS / 2, (COLUMNS / 2) - 3) # set cursor at the center of the screen including length of "LEVEL UP" text
    print "LEVEL UP"
    sleep(2)
    clear_screen

end