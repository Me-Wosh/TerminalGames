require "io/console"
require "./obstacle.rb"
require "./position.rb"
require "./screen.rb"
require "../colors.rb"
require "../terminal_commands.rb"

ROWS = 20
COLUMNS = 60

if __FILE__ == $0

    default_terminal_size = get_terminal_size()
    setup_terminal(ROWS, COLUMNS)

    obstacles = []

    last_obstacle_spawn = Time.now() - Obstacle.spawn_delay
    last_obstacle_move = Time.now() - Obstacle.move_delay

    game_loop = true

    while game_loop

        key = STDIN.read_nonblock(1) rescue nil

        if key

            if key == 'q'
                game_loop = false
            end

        end

        now = Time.now()

        if now >= last_obstacle_move + Obstacle.move_delay
            
            obstacle_to_delete = nil

            obstacles.each do | obstacle |

                if not obstacle.touched_barrier()
                    obstacle.move() # either i have hallucinations or some obstacles "jump" few columns after spawn instead of moving smoothly
                    last_obstacle_move = now 
                else
                    obstacle_to_delete = obstacle
                end

            end

            if obstacle_to_delete
                obstacles.delete(obstacle_to_delete)
            end
            
            clear_screen()

        end

        if now >= last_obstacle_spawn + Obstacle.spawn_delay
            obstacles.append(Obstacle.new())
            last_obstacle_spawn = now
        end

        draw_screen(obstacles)

    end

    reset_terminal(default_terminal_size.first, default_terminal_size.last)

end