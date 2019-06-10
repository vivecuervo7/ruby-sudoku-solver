require "tty-table" # used to render sudoku board
require_relative "classes/sudoku_board.rb"
require_relative "classes/sudoku_cell.rb"

def main
    puts "Enter your sudoku puzzle, blank spaces as periods or zeroes (..1..2.3.4..5) or (0010020304005), or press enter to use a sample puzzle"
    table = TTY::Table.new rows: SudokuBoard.new(gets.chomp).format_as_two_dimensional_array
    renderer = TTY::Table::Renderer::Unicode.new(table)
    renderer.padding = [0,1]
    renderer.border.separator = :each_row
    puts renderer.render
end

main # run program