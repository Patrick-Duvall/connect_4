
  class Board
    def initialize
      @board = Array.new(6) { Array.new(7) { "." } }
      @player = 'human'
    end

    def switch_player
    @player == 'human' ? @player = 'computer' : @player = 'human'
    end

    def print_board
      puts 'A B C D E F G'
      @board.each{|el| puts el.join(' ')}
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
#Bug, cant move onto full columns, crashes
    def comp_move
      column = (0..6).to_a.sample
      if column_available?(column)
        count = -1
        until @board[count][column] == '.'
          count -= 1
        end
        @board[count][column] = 'O'
      else
        comp_move()
      end
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

          diagonals.any? {|diag|diag.each_cons(4).to_a.any? { |combo| all_equal?(combo) } }
        end
        def won?
          wins_diagonal_combined || wins_vertical || wins_horizontal
        end
        def drawn?
          @board.flatten.none?{|space| space == '.'} && !won?()
        end
        def who_won
          puts @player == 'human' ? 'You win!' : 'Computer wins'
        end
        def game_over?
          drawn? || won?
        end

  end
