require_relative "board"
require_relative "tile"


class Minesweeper
  
    def initialize
        @board = Board.new
        @board.bombing
        @board.tile_placement
        
    end

    def valid_pos?(pos)
        pos.is_a?(Array) && pos.length == 2 && pos.all? { |x| x.between?(0, 8) } && !@board[pos].revealed?
    end

    def parse_pos(str)
        str.split(",").map { |char| Integer(char) }
    end

    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Please enter a position on the board like (2,4)"
            print "> "

            begin
                pos = parse_pos(gets.chomp)
            rescue
                puts "Invalid position entered (did you use a comma?)"
                puts ""
                pos = nil
            end
        end
        pos
    end

    def solved?
        @board.solved?
    end

    def lost?
        @board.lost?
    end


    def play_turn
        @board.render
        pos = get_pos
        @board[pos].reveal  
        p @board              
    end

    def run
        play_turn until lost? || solved?
        @board.render
        if solved? 
            puts "Congratulations you won!!"
        elsif lost?
            puts "You lost!!"
        end
    end

    private
    attr_reader :board
end

game = Minesweeper.new
game.run