require "../terminal_commands.rb"
require "io/console"
require "./screen.rb"
require "./target.rb"
require "./player.rb"
require "./shield.rb"
require "./player_bullet.rb"
require "./target_bullet.rb"

ROWS = 20
COLUMNS = 42

$game_loop = true
$score = 0
$level = 1
$targets = []
$shields = []
$special_target = nil
$target_bullet = nil
$player_bullet = nil

def generate_targets(start_row, start_column, end_row, end_column)

    targets = []

    for row in (start_row...end_row)
        for column in (start_column..end_column - 2).step(2)
            target = Target.new(row, column, WHITE)
            targets.append(target)
        end
    end

    return targets

end

def get_random_target_position(targets)

    random = Random.new
    random_index = random.rand(targets.length)
    random_target_position = [targets[random_index].position[0], targets[random_index].position[1]] # make sure to make an actual copy of the array instead of creating a reference
    random_target_position[0] += 1

    while targets.any? { |target| target.position[1] == random_target_position[1] and target.position[0] > random_target_position[0] }
        random_target_position[0] += 1
    end

    return random_target_position
    
end

def generate_shields(player_row, height)

    shields = []
    start_row = player_row - height - 1

    for row in (start_row...(start_row + height))

        for column in (4..(COLUMNS - 2))
            
            if (column / 4) % 2 != 0 # a group of 4 shields next to each other with 4 gaps after the group
                shield = Shield.new(row, column)
                shields.append(shield)
            end

        end

    end

    return shields
    
end

def player_hit
    
    if $target_bullet and $target_bullet.position == Player.position
        return true
    else
        return false
    end

end

def bullets_collision

    if $target_bullet and $player_bullet and $target_bullet.position == $player_bullet.position
        return true
    else
        return false
    end

end


if __FILE__ == $0

    all_targets_count = 0
    targets_direction = "right"
    targets_move_delay = 1.5 # 1 => 1 second, 0.5 => 500 milliseconds
    targets_shoot_delay = 0.25
    targets_bullet_move_delay = 0.08
    targets_move_time = Time.now + targets_move_delay
    targets_shoot_time = nil
    targets_bullet_move_time = Time.now + targets_bullet_move_delay
    
    special_target_spawn_delay = 40
    special_target_spawn_time = nil
    special_target_move_time = nil
    special_target_move_delay = 0.25

    player_bullet_move_delay = 0.05
    player_bullet_move_time = Time.now + player_bullet_move_delay

    health_bonus_required_score = 0

    initial_size = get_terminal_size
    hide_key_input
    set_title("Space Invaders")
    set_terminal_size(ROWS, COLUMNS)
    move_cursor(1, 1)
    clear_screen
    hide_cursor

    while $game_loop

        current_time = Time.now

        if not $targets.any?

            if $score > 0
                $level += 1
                next_level_animation
            end

            $target_bullet = nil
            $player_bullet = nil
            $special_target = nil

            Player.position = [ROWS - 1, COLUMNS / 2]

            $targets = generate_targets(4, 3, 7, COLUMNS)
            all_targets_count = $targets.length
            health_bonus_required_score = all_targets_count * 3 if health_bonus_required_score == 0

            special_target_spawn_time = current_time + special_target_spawn_delay
            special_target_move_time = special_target_spawn_time

            $shields = generate_shields(Player.position[0], 2)

            if $score >= health_bonus_required_score
                if Player.health < Player.max_health
                    Player.health += 1
                end

                health_bonus_required_score += all_targets_count * 3
            end

            if targets_move_delay > 0.4
                targets_move_delay -= 0.05
                special_target_spawn_delay -= 1.34
            end
        end

        if $targets.last and $targets.last.position[0] >= Player.position[0]
            $game_loop = false
        end

        if player_hit
            if Player.health > 1 
                Player.health -= 1
                sleep(3)
            
            else
                $game_loop = false
            end
        end

        if $player_bullet and $player_bullet.position[0] <= 2 # top barrier
            $player_bullet = nil
            clear_screen
        end
    
        if $target_bullet and $target_bullet.position[0] >= ROWS - 1 # bottom barrier
            $target_bullet = nil
            clear_screen
        end
    
        if bullets_collision
            $target_bullet = nil
            $player_bullet = nil
            clear_screen
        end    

        if not $special_target and not special_target_spawn_time
            special_target_spawn_time = current_time + special_target_spawn_delay
        end

        if not $special_target and current_time >= special_target_spawn_time
            $special_target = Target.new(3, 1, RED)
            special_target_spawn_time = nil
        end

        if not $target_bullet and not targets_shoot_time
            targets_shoot_time = current_time + targets_shoot_delay + (all_targets_count - $targets.length) * 0.02
        end

        if not $target_bullet and current_time >= targets_shoot_time
            $target_bullet = TargetBullet.new
            random_position = get_random_target_position($targets)
            $target_bullet.shoot(random_position[0], random_position[1])

            targets_shoot_time = nil
        end

        if current_time >= targets_move_time

            targets_move_time = current_time + targets_move_delay

            case targets_direction
        
            when "right"
        
                if $targets.any? { |target| target.position[1] >= COLUMNS }
                    $targets.each do |target|
                        target.position[0] += 1
                    end
                    
                    targets_direction = "left"
                else
                    $targets.each do |target|
                        target.position[1] += 1
                    end
                end
        
            when "left"
                
                if $targets.any? { |target| target.position[1] <= 1 }
                    $targets.each do |target|
                        target.position[0] += 1
                    end
                
                    targets_direction = "right"
                else
                    $targets.each do |target|
                        target.position[1] -= 1
                    end
                end

            end
            
            clear_screen
        end

        if $player_bullet and current_time >= player_bullet_move_time
            player_bullet_move_time = current_time + player_bullet_move_delay
            $player_bullet.move
            clear_screen
        end

        if $target_bullet and current_time >= targets_bullet_move_time
            targets_bullet_move_time = current_time + targets_bullet_move_delay
            $target_bullet.move
            clear_screen
        end

        if $special_target and current_time >= special_target_move_time
            if $special_target.position[1] < COLUMNS
                $special_target.position[1] += 1
                special_target_move_time = current_time + special_target_move_delay
            else
                $special_target = nil
                special_target_spawn_time = current_time + special_target_spawn_delay
            end

            clear_screen
        end


        key = STDIN.read_nonblock(1) rescue nil
        
        case key
            when 'q'
                $game_loop = false
        
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
        
            when ' ' # spacebar
                if not $player_bullet
                    $player_bullet = PlayerBullet.new
                    $player_bullet.shoot(Player.position[0] - 1, Player.position[1])
                end
        end
    
        draw_screen
        move_cursor(1,1)
        
    end

    set_terminal_size(initial_size[0], initial_size[1])
    clear_screen
    move_cursor(1, 1)
    print "Game Over, Score: #{$score}, Level: #{$level}"
    show_key_input
    show_cursor
    font_color(DEFAULT)

end