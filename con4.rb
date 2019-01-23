
  class Board
    def initialize
      @board = Array.new(6) { Array.new(7) { "." } }
    end

    def print_board
      puts 'ABCDEFG'
      @board.each{|el| puts el.join}
    end

    def move_to_index(move_column)
      move_column.ord - 65
    end

    def get_move
      puts "Enter a column, A-G >"
      move = gets.chomp
      move.match(/[a-g]/i) ? move_to_index(move.upcase) : get_move
    end

    def column_available?(column)
      @board.any?{|row| row[column] == '.'}
    end
#Gets move, checks if available, fills in if yes, else asks for different move
    def player_move
      column = get_move()
      if column_available?(column)
      count = -1
      until @board[count][column] == '.'
        count -= 1
      end
      @board[count][column] = 'X'
      else
        puts 'Column full, please enter a different move.'
        player_move()
      end
    end

    def comp_move
      column = (0..6).to_a.sample
      comp_move until column_available?(column)
      count = -1
      until @board[count][column] == '.'
        count -= 1
      end
      @board[count][column] = 'O'
    end

    def all_equal?(array)
      array.uniq.count == 1 && array.uniq != ['.']
    end


    def wins_horizontal
      combos = @board.map{|row| row.each_cons(4).to_a}.flatten(1)
      combos.any?{|combo| all_equal?(combo)}
    end

    def wins_vertical
      combos = @board.transpose.map{|col| col.each_cons(4).to_a}.flatten(1)
      combos.any?{|combo| all_equal?(combo)}
    end

# Finds diagonals by 
    def wins_diagonal_forwards
      padding = @board.size - 1
      padded_matrix = []
      @board.each do |row|
        inverse_padding = @board.size - padding
        padded_matrix << ([nil] * inverse_padding) + row + ([nil] * padding)
        padding -= 1
      end
      padded_matrix.transpose.map(&:compact)
    end


        def wins_diagonal_backwards
          padding = 1
          padded_matrix = []
          @board.each do |row|
            inverse_padding = @board.size - padding
            padded_matrix << ([nil] * inverse_padding) + row + ([nil] * padding)
            padding += 1
          end
          padded_matrix.transpose.map(&:compact)
        end

        def wins_diagonal_combined
          diagonals = wins_diagonal_forwards + wins_diagonal_backwards
          p diagonals
          diagonals.any? {|diag|diag.each_cons(4).to_a.any? { |combo| all_equal?(combo) } }
        end

  end

board = Board.new

10.times do
  board.player_move
  end
board.print_board

# p board.wins_diagonal_forwards
# p board.wins_diagonal_backwards
p board.wins_diagonal_combined