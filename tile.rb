
class Tile
    attr_reader :value

    def initialize(value)
        @value = value
        @state = false
    end

    def bombed?
        self.value == "@"
    end

    def flagged?
        self.value == "F"
    end

    def revealed?
        @state
    end

    def reveal
        if revealed?
            puts "this tile has been revealed"
        elsif flagged?
            puts "This tile cant be revealed becouse it is flagged"
        else
            @state = true
        end
    end

    def to_s
        if @state == false
            "◼"
        else
            value
        end
    end
end

