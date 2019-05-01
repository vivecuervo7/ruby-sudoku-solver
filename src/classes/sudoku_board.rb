class SudokuBoard
    def initialize
        @cells = instantiate_board
        @neighbors = []
    end

    def instantiate_board
        board = []
        for row in (0..8) do
            for col in (0..8) do
                default_value = row * 9 + (col + 1)
                board << SudokuCell.new(row, col, default_value)
            end
        end
        return board
    end

    def identify_neighbors(cell)
        for i in 0..9 do
            # Get all cell addresses in relevant row and column
            @neighbors << @cells[cell.x][i]
            @neighbors << @cells[i][cell.y]

            # Get all cells in it's set-of-three
        end
    end

    def format_as_two_dimensional_array
        board = Array.new(9) { Array.new(9) }
        @cells.each { |cell|
            board[cell.x][cell.y] = cell.value
        }
        return board
    end
end