require "io/console"
require "./directions.rb"
require "./food.rb"
require "./game_modes.rb"
require "./position.rb"
require "./screen.rb"
require "./snake.rb"
require "../terminal_commands.rb"
require "../colors.rb"

ROWS = 30
COLUMNS = 80
$score = 1

def get_all_positions()
    positions = []

    for i in (4...ROWS)
        for j in (2...COLUMNS)
            positions.append(Position.new(i, j))
        end
    end

    return positions
end

def border_collision(snake)
    return snake.head.y <= 3 || snake.head.y >= ROWS || snake.head.x <= 1 || snake.head.x >= COLUMNS
end

def body_collision(snake)
    bodies_excluding_head = snake.bodies_positions[1...snake.bodies_positions.length]

    # if there is still a body segment which has the same position as head even though head was just removed it 
    # means that head collided with another body part
    return bodies_excluding_head.include? snake.head
end

if __FILE__ == $0
    initial_terminal_size = get_terminal_size()
    set_terminal_size(ROWS, COLUMNS)
    hide_cursor()
    hide_key_input()
    clear_screen()
    move_cursor(1, 1)

    game_mode = nil
    option = 0

    game_loop = true

    all_positions = get_all_positions()

    snake = nil
    time_to_move_snake = nil
    food = nil

    while game_loop
        if !game_mode
            main_menu(option)

            # get user key input without blocking the program
            key = STDIN.read_nonblock(1) rescue nil
        
            if !key
                next
            end

            # space
            if key == " "
                case option
                    when 0
                        game_mode = CLASSIC
                        $score = 1
                        
                        snake = Snake.new(ROWS / 2, COLUMNS / 2, game_mode, all_positions.length)
                        time_to_move_snake = Time.now() + snake.delay

                        clear_screen()

                    when 1
                        game_mode = SPEED
                        $score = 1

                        snake = Snake.new(ROWS / 2, COLUMNS / 2, game_mode, all_positions.length)
                        time_to_move_snake = Time.now() + snake.delay

                        clear_screen()

                    when 2
                        game_loop = false
                        clear_screen()
                        break
                end
            end

            # up arrow
            if key == "A"
                clear_screen()

                if option == 0
                    option = 2
                else
                    option -= 1
                end
            end

            # down arrow
            if key == "B"
                clear_screen()

                if option == 2
                    option = 0
                else
                    option += 1
                end
            end
                
            next
        end

        if border_collision(snake) || body_collision(snake)
            game_loop = false
            game_over(initial_terminal_size.first)
            break
        end

        now = Time.now()

        if now >= time_to_move_snake
            clear_screen()
            snake.move()
            time_to_move_snake = now + snake.delay 
        end

        if !food
            # exclude snake bodies from available positions
            available_positions = all_positions.reject { | position | snake.bodies_positions.include? position }

            if available_positions.length <= 0
                game_loop = false
                game_won(initial_terminal_size.first)
                break
            end

            food = Food.new(available_positions)
        end
        
        if snake.head == food.position
            $score += 1
            food = nil
            snake.grow()
        end

        key = STDIN.read_nonblock(1) rescue nil
        
        if key
            if key == "q"
                game_mode = nil
                clear_screen()
                next
            end

            previous_direction = snake.direction

            # up arrow
            if key == "A"
                snake.direction = UP
            end

            # down arrow
            if key == "B"
                snake.direction = DOWN
            end

            # right arrow
            if key == "C"
                snake.direction = RIGHT
            end

            # left arrow
            if key == "D"
                snake.direction = LEFT
            end

            if previous_direction != snake.direction
                clear_screen()
                snake.move()
                time_to_move_snake = now + snake.delay
            end
        end

        draw_screen(snake, food)
    end

    set_terminal_size(initial_terminal_size.first, initial_terminal_size.last)
    show_cursor()
    show_key_input()
    font_color(DEFAULT)
end