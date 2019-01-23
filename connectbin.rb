require_relative 'con4.rb'

board = Board.new


until board.game_over?
  board.player_move
  break if board.game_over?
  board.switch_player
  board.comp_move
  break if board.game_over?
  board.switch_player
  board.print_board
end
board.print_board
board.who_won if board.won?
 puts "Draw!!" if board.drawn?
