class SudokuCell
    attr_accessor :value
    attr_reader :x, :y
    def initialize(x, y, value)
        @x = x
        @y = y
        @value = value
    end

    def equals?(other)
        return @x == other.x && @y == other.y
    end
end