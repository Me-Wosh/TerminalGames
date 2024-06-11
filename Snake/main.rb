require "io/console"
require "./position.rb"
require "./snake.rb"
require "./food.rb"
require "./screen.rb"
require "./directions.rb"
require "../terminal_commands.rb"
require "../colors.rb"

ROWS = 20
COLUMNS = 40
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

    game_loop = true

    snake = Snake.new(ROWS / 2, COLUMNS / 2)
    time_to_move_snake = Time.now() + snake.speed

    all_positions = get_all_positions()

    # exclude snake head from available positions
    food = Food.new(all_positions.reject { | position | snake.bodies_positions.include? position })

    while game_loop
        if border_collision(snake) || body_collision(snake)
            game_loop = false
            game_over()
            break
        end

        now = Time.now()

        if now >= time_to_move_snake
            clear_screen()
            snake.move()
            time_to_move_snake = now + snake.speed 
        end
        
        if snake.head == food.position
            $score += 1
            food = nil
            snake.grow()
        end

        if !food
            # exclude snake bodies from available positions
            available_positions = all_positions.reject { | position | snake.bodies_positions.include? position }

            if available_positions.length <= 0
                game_loop = false
                game_won()
                break
            end

            food = Food.new(available_positions)
        end   

        # get user key input without blocking the program
        key = STDIN.read_nonblock(1) rescue nil
        
        if key
            if key == "q"
                game_loop = false
                game_over()
                break
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
                time_to_move_snake = now + snake.speed
            end
        end

        draw_screen(snake, food)
    end

    set_terminal_size(initial_terminal_size.first, initial_terminal_size.last)
    show_cursor()
    show_key_input()
    font_color(DEFAULT)
end