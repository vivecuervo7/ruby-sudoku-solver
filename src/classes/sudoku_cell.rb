class SudokuCell
    attr_reader :x, :y, :value

    def initialize(x, y, value)
        @x = x
        @y = y
        @value = value
        @options = (1..9).to_a
        @used_options = []
    end

    def assign_value(unavailable_options)

        # Remove unavailable options due to used or neighbor cell
        @options -= unavailable_options
        @options -= @used_options

        # Assign a value if options are greater than zero, and add that selection to used_options
        if @options.length > 0
            @value = @options.shuffle.shift
            @used_options[@used_options.length] = @value
            puts "#{"|  " * $tab_depth}#{@x},#{@y}\tusing value [#{@value}] from options #{@options}"
            return true
        end

        # Otherwise, reset value to zero and return false, so sudoku_board will backtrack through previous options
        puts "\e[41m#{"|  " * $tab_depth}#{@x},#{@y}\e[0m"
        reset
        return false
    end

    def reset(hard_reset = false)
        # Reset value and options, if hard_reset due to consecutive backtracks, also reset used_options
        @value = 0
        @options = (1..9).to_a
        if hard_reset
            @used_options.clear
        end
    end

    def ==(other)
        return @x == other.x && @y == other.y
    end
end