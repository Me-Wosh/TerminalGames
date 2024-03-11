require "../terminal_commands.rb"
require "./target.rb"

Rows = 20
Columns = 40

$targets = []

$direction = "right"

def generate_targets(start_row, start_column)
    for row in (start_row...Rows/3)
        for column in (start_column..Columns-2).step(2)
            target = Target.new(row, column)
            $targets.append(target)
        end
    end
end

def draw_screen
    for row in (1..Rows)
        for column in (1..Columns)
            if $targets.any? { |target| target.position == [row, column]}
                print '*'
            else
                print "\u00a0"
            end
        end
        
        if not row == Rows
            puts ""
        end
    end
end

def move_targets
    case $direction

    when "right"
        if $targets.any? { |target| target.position[1] >= Columns }
            for target in $targets
                target.position[0] += 1
                $direction = "left"
            end
        
        else
            for target in $targets
                target.position[1] += 1
            end
        end
    
    when "left"
        if $targets.any? { |target| target.position[1] <= 1 }
            for target in $targets
                target.position[0] += 1
                $direction = "right"
            end
        
        else
            for target in $targets
                target.position[1] -= 1
            end
        end
    end
end

def down_barrier_collision
    return $targets.any? { |target| target.position == [Rows, 1] }
end

if __FILE__ == $0
    move_cursor(1, 1)

    set_size(Rows, Columns)
    clear_screen
    hide_cursor

    generate_targets(3, 3)

    while true
        if (down_barrier_collision)
            break
        end

        move_targets
        
        clear_screen
        draw_screen

        sleep(0.1)
    end
end