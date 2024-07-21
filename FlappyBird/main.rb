require "io/console"
require "./bird.rb"
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

    bird = Bird.new()

    obstacles = []
    last_obstacle_spawn = Time.now() - Obstacle.spawn_delay
    last_obstacle_move = Time.now() - Obstacle.spawn_delay

    game_loop = true

    while game_loop

        now = Time.now()

        key = STDIN.read_nonblock(1) rescue nil

        if key

            if key == 'q'
                game_loop = false
            elsif key == ' '
                bird.fly_upwards()
                clear_screen()
            end

        end

        bird.previous_position = Position.new(bird.position.y, bird.position.x)
        bird_free_fall_amount = (9.8 * (now - bird.free_fall_start) ** 2) / 2 # i passed physics
        bird.position.y = bird.free_fall_initial_height + bird_free_fall_amount.floor()

        if bird.position.y != bird.previous_position.y
            clear_screen()
        end

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

        draw_screen(bird, obstacles)

    end

    reset_terminal(default_terminal_size.first, default_terminal_size.last)

end