class SudokuCell
    attr_accessor :value
    attr_reader :x, :y#, :value # Swap this back to attr_reader

    def initialize(x, y, value)
        @x = x
        @y = y
        @value = value
        @options = [1,2,3,4,5,6,7,8,9]
        @used_options = []
    end

    def assign_value(unavailable_options)
        @options -= unavailable_options
        @options -= @used_options
        if @options.length > 0
            @value = @options.shuffle.shift
            @used_options[@used_options.length] = @value
            #puts "Success\t\t(#{@x},#{@y}),\tunavailable #{unavailable_options}, remaining #{@options}, used#{@used_options}, assigned #{value}"
            puts "   \t(#{@x},#{@y})\tusing value [#{@value}] from options #{@options}"
            return true
        end
        puts "ERR\t(#{@x},#{@y})\treset value [ ] backtrack"
        reset
        #puts "Backtrack\t(#{@x},#{@y}),\tunavailable #{unavailable_options}, remaining #{@options}, used#{@used_options}, reset to #{value}"
        return false
    end

    def reset(hard = false)
        @value = 0
        @options = [1,2,3,4,5,6,7,8,9]
        @used_options = [] if hard
    end

    def equals?(other)
        return @x == other.x && @y == other.y
    end
end