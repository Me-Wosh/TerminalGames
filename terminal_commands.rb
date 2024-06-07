require "io/console"

def clear_screen
    print "\e[2J"
end

def clear_history
    print "\e[3J"
end

def get_terminal_size
    return IO.console.winsize
end

def set_terminal_size(rows, columns)
    print "\e[8;#{rows};#{columns}t"
end

def set_title(title)
    print "\e]0;#{title}\e\\"
end

def hide_key_input
    STDIN.raw!
end

def show_key_input
    STDIN.cooked!
end

def hide_cursor
    print "\e[?25l"
end

def show_cursor
    print "\e[?25h"
end

def move_cursor(rows, columns)
    print "\e[#{rows};#{columns}H"
end

def cursor_up(amount)
    print "\e[#{amount}A"
end

def cursor_down(amount)
    print "\e[#{amount}B"
end

def cursor_right(amount)
    print "\e[#{amount}C"
end

def cursor_left(amount)
    print "\e[#{amount}D"
end

def cursor_current_line_beggining
    print "\r"
end

def cursor_next_line_beggining(amount)
    print "\e[#{amount}E"
end

def font_color(color)
    print "\e[#{color}m"
end