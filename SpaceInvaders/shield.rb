require "../colors.rb"

class Shield
   
    def initialize(row, column)
        @position = [row, column]
        @health = 2
    end

    def position
        return @position
    end
    
    def health
        return @health
    end

    def health=(value)
        @health = value
    end

    def color
        return @color = GREEN
    end

end