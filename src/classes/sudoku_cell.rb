class SudokuCell
    attr_reader :x, :y, :value, :predefined, :options

    def initialize(x, y, value)
        @x = x
        @y = y
        @value = value
        @predefined = false
        @options = (1..9).to_a
        @used_options = []
    end

    def assign_predefined_value(value)
        @value = value
        @predefined = true
    end

    def calculate_options(unavailable_options)
        # Remove unavailable options due to used or neighbor cell
        @options -= unavailable_options
        @options -= @used_options
    end

    def assign_value(unavailable_options)
        # Remove unavailable options due to used or neighbor cell
        calculate_options(unavailable_options)

        # Assign a value if options are greater than zero, and add that selection to used_options
        if @options.length > 0
            @value = @options.shuffle.shift
            @used_options[@used_options.length] = @value
            return true
        end

        # Otherwise, reset value to zero and return false, so sudoku_board will backtrack through previous options
        reset
        return false
    end

    def reset(hard_reset = false)
        # Ignore reset if cell was predefined due to supplied puzzle
        if !@predefined
            # Reset value and options, if hard_reset due to consecutive backtracks, also reset used_options
            @value = 0
            @options = (1..9).to_a
            if hard_reset
                @used_options.clear
            end
        end
    end

    def ==(other)
        return @x == other.x && @y == other.y
    end

    def to_s
        return "#{@x},#{@y} : #{@value}"
    end
end