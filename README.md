# Sudoku
In terminal Sudoku generator and solver built in Ruby

## Usage
Navigate to project root and run `bundle install` if first run, then `ruby src/sudoku.rb` to execute program

## Output
Terminal will show the resulting complete game board, along with output showing working along the way. Backtracking blocks are displayed through indentation, and where coordinates are listed in red are where the program is left with no valid options and thus forced into backtracking through previous cells that had mutliple options

## Future Enhancements
* Intention is to have the table render as a 3x3 grid, each cell holding a nested 3x3 non-bordered grid. Currently having issues getting TTY-table to render as intended, and will require some manipulation of the sudoku_board's resulting array

* Once rendering is complete, functionality to take partial puzzle input will be added, and will return the solved puzzle. Assumption will be that only solveable puzzles are submitted to the program, but it may be feasible to add functionality to handle unsolveable puzzles. Puzzle submission will follow a predefined format, but may be extended to handle multiple input patterns (comma separated, space separated, no spacing etc)

* The next feature to be added will be a board generator, which will essentially solve an empty board and remove `n` cells while ensuring that the puzzle remains both solveable and unique. A difficulty selection will determine how may cells are to be removed. Program should also output in multiple formats (comma separated, space separated, no spacing etc) if the user wishes, in case they are generating the puzzle to be copied into another piece of software that requires a certain formatting