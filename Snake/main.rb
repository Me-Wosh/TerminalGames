require "io/console"
require "./snake.rb"
require "./screen.rb"
require "../terminal_commands.rb"

ROWS = 20
COLUMNS = 40
$score = 0

if __FILE__ == $0
    initial_terminal_size = get_terminal_size()
    set_terminal_size(ROWS, COLUMNS)
    hide_cursor()
    hide_key_input()
    clear_screen()
    move_cursor(1, 1)
    draw_borders()

    game_loop = true

    snake = Snake.new(ROWS / 2, COLUMNS / 2)
    time_to_move_snake = Time.now() + snake.speed

    while game_loop

        now = Time.now()

        if now >= time_to_move_snake
            clear_screen
            snake.move()
            time_to_move_snake = now + snake.speed
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

        draw_screen(snake)
    end

    set_terminal_size(initial_terminal_size.first, initial_terminal_size.last)
    show_cursor()
    show_key_input()
end