require_relative 'tile'

class Board

    def self.empty_grid
        Array.new(9) do
            Array.new(9) {Tile.new(0)}
        end
    end

    def initialize(grid = self.class.empty_grid)
        @grid = grid
    end
    
    def bombing
        coordinates = []
        while coordinates.length < 10
            current_co = [] 
            2.times do 
                current_co << rand(8)
            end
            if !coordinates.include?(current_co)
                coordinates << current_co
                @grid[current_co[0]][current_co[1]] = Tile.new("@") 
            end
        end
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        @grid.each_with_index do |row, i|
            puts "#{i} #{row.join(" ")}"
        end
    end

    def tile_placement
        @grid.each_with_index do |row, i|
            row.each_with_index do |ele, j|
                neighbour_bomb_count = 0
                if ele.value != "@"
                    if @grid[i+1] != nil && @grid[i+1][j-1] != nil
                        if @grid[i+1][j-1].bombed?
                            neighbour_bomb_count += 1
                        end
                    end

                    if @grid[i+1] != nil && @grid[i+1][j] != nil
                        if @grid[i+1][j].bombed?
                            neighbour_bomb_count += 1
                        end
                    end

                    if @grid[i+1] != nil && @grid[i+1][j+1] != nil
                        if @grid[i+1][j+1].bombed?
                            neighbour_bomb_count += 1
                        end
                    end

                    if @grid[i]!= nil && @grid[i][j+1] != nil
                        if @grid[i][j+1].bombed?
                            neighbour_bomb_count += 1
                        end
                    end

                    if @grid[i-1] != nil && @grid[i-1][j+1] != nil
                        if @grid[i-1][j+1].bombed?
                            neighbour_bomb_count += 1
                        end
                    end

                    if @grid[i-1]!= nil && @grid[i-1][j] != nil
                        if @grid[i-1][j].bombed?
                            neighbour_bomb_count += 1
                        end
                    end

                    if @grid[i-1]!= nil && @grid[i-1][j-1] != nil
                        if @grid[i-1][j-1].bombed?
                            neighbour_bomb_count += 1
                        end
                    end

                    if @grid[i]!= nil && @grid[i][j-1] != nil
                        if @grid[i][j-1].bombed?
                            neighbour_bomb_count += 1
                        end
                    end
                
                    if neighbour_bomb_count == 0
                        @grid[i][j] = Tile.new("_")
                    else
                        @grid[i][j] = Tile.new("#{neighbour_bomb_count}")
                    end
                end
            end
        end
    end

    def [](pos)
        x, y = pos
        @grid[x][y]
    end

    def big_reveal(val, pos)
        i = pos[0]
        j = pos[1]
        if val.value == "_"
            val.reveal
                if (@grid[i+1]) != nil && (@grid[i+1][j-1]) != nil && !(@grid[i+1][j-1]).revealed?
                    if (@grid[i+1][j-1]).value == "_"
                        big_reveal(@grid[i+1][j-1], [i+1, j-1])
                    else
                        (@grid[i+1][j-1]).reveal
                    end
                end

                if (@grid[i+1]) != nil && (@grid[i+1][j]) != nil && !(@grid[i+1][j]).revealed?
                    if (@grid[i+1][j]).value == "_"
                        big_reveal(@grid[i+1][j], [i+1, j])
                    else
                        (@grid[i+1][j]).reveal
                    end
                end

                if (@grid[i+1]) != nil && (@grid[i+1][j+1]) != nil && !(@grid[i+1][j+1]).revealed?
                    if (@grid[i+1][j+1]).value == "_"
                        big_reveal(@grid[i+1][j+1], [i+1, j+1])
                    else
                        (@grid[i+1][j+1]).reveal
                    end
                end

                if (@grid[i]) != nil && (@grid[i][j+1]) != nil && !(@grid[i][j+1]).revealed?
                    if (@grid[i][j+1]).value == "_"
                        big_reveal(@grid[i][j+1], [i, j+1])
                    else
                        (@grid[i][j+1]).reveal
                    end
                end

                if (@grid[i-1]) != nil && (@grid[i-1][j+1]) != nil && !(@grid[i-1][j+1]).revealed?
                    if (@grid[i-1][j+1].value) == "_"
                        big_reveal(@grid[i-1][j+1], [i-1, j+1])
                    else
                        (@grid[i-1][j+1]).reveal
                    end
                end

                if (@grid[i-1]) != nil && (@grid[i-1][j]) != nil && !(@grid[i-1][j]).revealed?
                    if (@grid[i-1][j]).value == "_"
                        big_reveal(@grid[i-1][j] , [i-1, j])
                    else
                        (@grid[i-1][j]).reveal
                    end
                end

                if (@grid[i-1]) != nil && (@grid[i-1][j-1]) != nil && !(@grid[i-1][j-1]).revealed?
                    if (@grid[i-1][j-1]).value == "_"
                        big_reveal(@grid[i-1][j-1], [i-1, j-1])
                    else
                        (@grid[i-1][j-1]).reveal
                    end
                end

                if (@grid[i]) != nil && (@grid[i][j-1]) != nil && !(@grid[i][j-1]).revealed?
                    if (@grid[i][j-1]).value == "_"
                        big_reveal(@grid[i][j-1] , [i, j-1])
                    else
                        (@grid[i][j-1]).reveal
                    end
                end
        end
    end

    def solved?
        @grid.each do |row|
            row.each do |ele|
                if ele.bombed? && ele.revealed?
                    return false
                elsif !ele.bombed? && !ele.revealed?
                    return false
                end
            end
        end
        true
    end

    def lost?
        @grid.each do |row|
            row.each do |ele|
                if ele.bombed? && ele.revealed?
                    return true
                end
            end
        end
        false
    end

end
