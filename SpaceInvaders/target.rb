class Target

    @@symbol = "*"
    @@targets = []
    @@direction = "right"

    def initialize(row, column)
        @position = [row, column]
    end

    def position
        return @position
    end

    def self.symbol
        return @@symbol
    end

    def self.targets
        return @@targets
    end

    def self.generate_targets(start_row, start_column, max_rows, max_columns)

        for row in (start_row...max_rows / 3)
            for column in (start_column..max_columns - 2).step(2)
                target = new(row, column)
                @@targets.append(target)
            end
        end

    end

    def self.move_targets(rows, columns)
    
        case @@direction
    
        when "right"
            if @@targets.any? { |target| target.position[1] >=  columns } # right barrier collision
                
                if @@targets.any? { |target| target.position[0] >= rows - 1 } # player row collision 
                    exit
                else
                    for target in @@targets
                        target.position[0] += 1
                        @@direction = "left"
                    end
                end
            
            else
                for target in @@targets
                    target.position[1] += 1
                end
            end
    
        when "left"
            if @@targets.any? { |target| target.position[1] <= 1 } # left barrier collision
                for target in @@targets
                    target.position[0] += 1
                    @@direction = "right"
                end
            
            else
                for target in @@targets
                    target.position[1] -= 1
                end
            end
        end

    end

end