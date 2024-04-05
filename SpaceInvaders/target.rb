class Target

    def initialize(row, column)
        @position = [row, column]
    end

    def position
        return @position
    end

    def symbol
        return @symbol = "*"
    end

    def self.generate_targets(start_row, start_column, max_rows, max_columns)

        targets = []

        for row in (start_row...max_rows / 3)
            for column in (start_column..max_columns - 2).step(2)
                target = new(row, column)
                targets.append(target)
            end
        end

        return targets

    end

    def self.get_random_target_position(targets)
    
        random = Random.new
        random_index = random.rand(targets.length)
        random_target_position = [targets[random_index].position[0], targets[random_index].position[1]] # make sure we make an actual copy of the array instead of creating a reference
        random_target_position[0] += 1

        while targets.any? { |target| target.position[1] == random_target_position[1] and target.position[0] > random_target_position[0] }
            random_target_position[0] += 1
        end
    
        return random_target_position
        
    end

end