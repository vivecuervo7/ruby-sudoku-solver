class SudokuBoard
    def initialize
        @cells = instantiate_board
        populate_board
    end

    def instantiate_board
        board = []
        for row in (0..8) do
            for col in (0..8) do
                default_value = 0
                board << SudokuCell.new(row, col, default_value)
            end
        end
        return board
    end

    def populate_board
        i = 0;
        while i < 81 do
            if @cells[i] == nil
                puts "Cell is Nil at index #{i}"
            end
            #puts "\nChecking coordinates [#{@cells[i].x},#{@cells[i].y}]"# - following options available #{options}" # Testing
            if @cells[i].assign_value(identify_neighbors(@cells[i]).map { |c| c.value.to_i })
                i += 1
            else
                @cells[i].reset()
                @cells[i+1].reset(true)
                i -= 1
            end
        end

        # @cells.shuffle.each { |cell|
        #     options = [1,2,3,4,5,6,7,8,9]
        #     identify_neighbors(cell).each { |neighbor|
        #         if !neighbor.equals?(cell)
        #             options.delete(neighbor.value)
        #         end
        #     }

        #     puts "\nChecking coordinates [#{cell.x},#{cell.y}] - following options available #{options}" # Testing

        #     #if options.length > 0
        #         cell.value = options.shuffle[0]
        #     #end
        # }
    end

    def identify_neighbors(cell)
        neighbors = []
        
        # Get all cells in row and column
        for i in 0..8 do
            cells_checked = @cells.select { |c| ((c.x == cell.x && c.y == i) || (c.x == i && c.y == cell.y)) && c != nil && c.value.to_i > 0 }
            if cells_checked.length > 0
                neighbors << cells_checked[0]
            end
        end

        # Get all cells in block
        col_block_index = (cell.x / 3).to_i * 3
        row_block_index = (cell.y / 3).to_i * 3
        for i in col_block_index..col_block_index + 2 do
            for j in row_block_index..row_block_index + 2 do
                cells_checked = @cells.select { |c| c.x == i && c.y == j && c.value.to_i > 0 }
                if cells_checked.length > 0
                    neighbors << cells_checked[0]
                end
            end
        end

        # Remove self from neighbors
        neighbors.delete(cell)
        
        return neighbors
    end

    def format_as_two_dimensional_array
        board = Array.new(9) { Array.new(9) }
        @cells.each { |cell|
            board[cell.x][cell.y] = cell.value
        }
        return board
    end
end