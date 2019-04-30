require "tty-prompt" # used for menu navigation and option selection
require "tty-reader" # used to detect arrow keypresses to navigate sudoku board
require "tty-table" # used to render sudoku board

def main
    table = TTY::Table.new rows: generate_empty_board
    #puts table.render(:unicode)
    renderer = TTY::Table::Renderer::Unicode.new(table)
    renderer.padding = [0,1]
    renderer.border.separator = :each_row
    puts renderer.render
end

def generate_empty_board
    board = Array.new(9) { Array.new(9) }
    for row in (0..8) do
        for col in (0..8) do
            board[row][col] = " "
        end
    end
    return board
end

main # run program