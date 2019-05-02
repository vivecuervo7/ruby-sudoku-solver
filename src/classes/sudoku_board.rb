class SudokuBoard
    def initialize
        @cells = instantiate_board
        populate_board
    end

    def instantiate_board
        board = []
        # Populate board with array of sudoku_cell of size 81, default values of zero
        for row in (0..8) do
            for col in (0..8) do
                board << SudokuCell.new(row, col, 0)
            end
        end
        return board
    end

    def populate_board
        i = 0;
        while i < 81 do
            # Try to assign a value to current cell, increment i if operation was a success
            # identify_neighbors here passes current cell, returns array of neighboring cells
            # assign_value passes the array of neighbors mapped so as to only pass an array of the neighbors' values
            if @cells[i].assign_value(identify_neighbors(@cells[i]).map { |c| c.value.to_i })
                i += 1
                $tab_depth = [0, $tab_depth - 1].max
            else
                # Reset current cell to zero, reset that cell's options
                # Also reset used_options for the previously assessed cell to cover the case of consecutive backtracks
                @cells[i].reset()
                @cells[i+1].reset(true)
                i -= 1
                $tab_depth += 1
            end
        end
    end

    def identify_neighbors(cell)
        neighbors = []
        
        # Select all cells in row and column, excluding self and cells with values of zero, and append them to neighbors
        for i in 0..8 do
            @cells.select { |c| ((c.x == cell.x && c.y == i) || (c.x == i && c.y == cell.y)) && c != cell && c.value.to_i > 0 }.each { |ch| neighbors << ch }
        end

        # Select all cells in current block of nine cells, excluding self and cells with values of zero, and append them to neighbors
        col_block_index = (cell.x / 3).to_i * 3
        row_block_index = (cell.y / 3).to_i * 3
        for i in col_block_index..col_block_index + 2 do
            for j in row_block_index..row_block_index + 2 do
                @cells.select { |c| c.x == i && c.y == j && c != cell && c.value.to_i > 0 }.each { |ch| neighbors << ch }
            end
        end
        
        return neighbors
    end

    def format_as_two_dimensional_array
        # Return @cells formatted as an array, necessary for table rendering
        board = Array.new(9) { Array.new(9) }
        @cells.each { |cell|
            board[cell.x][cell.y] = cell.value
        }
        return board
    end
end