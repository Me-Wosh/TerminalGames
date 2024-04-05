require "../terminal_commands.rb"
require "../colors.rb"
require "./target.rb"
require "./player.rb"
require "./shield.rb"


$shields_starting_row = 0
$shields_ending_row = 0
$targets_starting_row = 0
$targets_ending_row = 0

def bullets_collision
    if $target_bullet and $player_bullet and $target_bullet.position == $player_bullet.position
        return true
    else
        return false
    end
end

def draw_screen

    if $player_bullet and $player_bullet.position[0] <= 1 # top barrier
        $player_bullet = nil
    end

    if bullets_collision
        $target_bullet = nil
        $player_bullet = nil
    end

    if $shields.any?
        $shields_starting_row = $shields.first.position[0]
        $shields_ending_row = $shields.last.position[0]
    end

    if $targets.any?
        $targets_starting_row = $targets.first.position[0]
        $targets_ending_row = $targets.last.position[0]
    end

    for row in (1..ROWS)

        if row == 1
            font_color(WHITE)
            print "Score: #{$score}"
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

            if row >= $targets_starting_row and row <= $targets_ending_row and target_index = $targets.index { |target| target.position == [row, column] }

                if $player_bullet and $targets[target_index].position == $player_bullet.position
                    $targets.delete_at(target_index)
                    $player_bullet = nil
                    $score += 1
                    cursor_right(1)

                elsif shield_index = $shields.index { |shield| shield.position == [row, column] }
                    $shields.delete_at(shield_index)
                    cursor_right(1)

                else
                    font_color(WHITE)
                    print $targets[target_index].symbol
                end

            elsif row >= $shields_starting_row and row <= $shields_ending_row and shield_index = $shields.index { |shield| shield.position == [row, column] }
                
                if $player_bullet and $player_bullet.position == $shields[shield_index].position
                    
                    $player_bullet = nil
                    cursor_right(1)

                    if $shields[shield_index].health > 1
                        $shields[shield_index].health -= 1
                    else
                        $shields.delete_at(shield_index)
                    end
                
                elsif $target_bullet and $target_bullet.position == $shields[shield_index].position

                    $target_bullet = nil
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