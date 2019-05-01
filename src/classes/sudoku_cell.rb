class SudokuCell
    attr_reader :x, :y, :value
    def initialize(x, y, value)
        @x = x
        @y = y
        @value = value
    end
end