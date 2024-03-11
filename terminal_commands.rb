def clear_screen
    print "\u001b[2J"
end

def set_size(rows, columns)
    print "\u001b[8;#{rows};#{columns}t"
end

def hide_cursor
    print "\u001b[?25l"
end

def show_cursor
    print "\u001b[?25h"
end

def move_cursor(rows, columns)
    print "\u001b[#{rows};#{columns}H"
end