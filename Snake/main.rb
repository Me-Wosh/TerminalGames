require "io/console"
require "./position.rb"
require "./snake.rb"
require "./food.rb"
require "./screen.rb"
require "../terminal_commands.rb"

ROWS = 20
COLUMNS = 40
$score = 0

def get_all_positions()
    positions = []

    for i in (4...ROWS)
        for j in (2...COLUMNS)
            positions.append(Position.new(i, j))
        end
    end

    return positions
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

    available_positions = get_all_positions()

    # exclude snake head position
    food = Food.new(available_positions.reject { | position | snake.bodies_positions.include? position })

    while game_loop

        now = Time.now()

        if now >= time_to_move_snake
            clear_screen()

            tail = snake.bodies_positions.last
            snake.move()

            if snake.head == food.position
                $score += 1
                food = nil
                snake.grow(tail)
            end

            time_to_move_snake = now + snake.speed
        end

        if food == nil
            food = Food.new(available_positions.reject { | position | snake.bodies_positions.include? position })
        end

        key = STDIN.read_nonblock(1) rescue nil

        case key
            when "q"
                game_loop = false

            # up arrow
            when "A"
                snake.direction = "UP"

            # down arrow
            when "B"
                snake.direction = "DOWN"

            # right arrow
            when "C"
                snake.direction = "RIGHT"

            # left arrow    
            when "D"
                snake.direction = "LEFT"
        end

        draw_screen(snake, food)        
    end

    set_terminal_size(initial_terminal_size.first, initial_terminal_size.last)
    show_cursor()
    show_key_input()
    font_color(DEFAULT)
end