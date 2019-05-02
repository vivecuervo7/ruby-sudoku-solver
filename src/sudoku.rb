require "tty-table" # used to render sudoku board
require_relative "classes/sudoku_board.rb"
require_relative "classes/sudoku_cell.rb"

# Global variable only being used to facilitate debugging
$tab_depth = 0

def main
    table = TTY::Table.new rows: SudokuBoard.new.format_as_two_dimensional_array
    renderer = TTY::Table::Renderer::Unicode.new(table)
    renderer.padding = [0,1]
    renderer.border.separator = :each_row
    puts renderer.render
end

main # run program