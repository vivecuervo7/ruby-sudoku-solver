class SudokuBoard
    def initialize
        @cells = instantiate_board
        @test_puzzle = "010020300004005060070000008006900070000100002030048000500006040000800106008000000"
        @test_puzzle_answer = "815627394924385761673491528186952473457163982239748615591236847342879156768514239"
        populate_board(@test_puzzle)
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

    def populate_board(puzzle = nil)
        # If a puzzle was supplied, pre-populate the board with those values
        if puzzle != nil
            puzzle.gsub!('.', '0')
            for i in 0..puzzle.length - 1 do
                if puzzle[i].to_i > 0
                    @cells[i].assign_predefined_value(puzzle[i].to_i)
                end
            end
        end

        # Pre-calculate all current cell's options
        for i in 0..@cells.length - 1 do
            @cells[i].calculate_options(identify_neighbors(@cells[i]).map { |c| c.value.to_i })
        end

        # Sort so that program will assess those with the fewest options first in an attempt to limit backtracking
        #@cells.sort_by! { |c| c.options.length }.reverse

        i = 0
        direction = 1
        while i < @cells.length do
            # Try to assign a value to current cell, increment i if operation was a success
            # identify_neighbors here passes current cell, returns array of neighboring cells
            # assign_value passes the array of neighbors mapped so as to only pass an array of the neighbors' values
            if @cells[i].predefined
                # If cell was predefined ignore value assignment, hard reset the previous cell if backtracking
                #if direction == -1
                    @cells[i + 1].reset(true)
                #end
            elsif @cells[i].assign_value(identify_neighbors(@cells[i]).map { |c| c.value.to_i })
                direction = 1
                # Testing output
                render_progress
            else
                # Reset current cell to zero, reset that cell's options
                # Also reset used_options for the previously assessed cell to cover the case of consecutive backtracks
                @cells[i].reset()
                @cells[i + 1].reset(true)
                direction = -1
                # Testing output
                render_progress
            end
            i += direction
        end
    end

    def render_progress
        # TESTING OUTPUT ONLY
        table = TTY::Table.new rows: format_as_two_dimensional_array
        renderer = TTY::Table::Renderer::Unicode.new(table)
        renderer.padding = [0,1]
        renderer.border.separator = :each_row
        puts renderer.render
        sleep 0.1
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
            correct = cell.value == @test_puzzle_answer[@cells.index(cell)].to_i
            #board[cell.x][cell.y] = cell.value > 0 ? cell.predefined ? "\e[36m#{cell.value}\e[0m" : cell.value : " "
            board[cell.x][cell.y] = cell.value > 0 ? cell.predefined ? "\e[36m#{cell.value}\e[0m" : correct ? "\e[32m#{cell.value}\e[0m" : "\e[31m#{cell.value}\e[0m" : " "
        }
        return board
    end
end