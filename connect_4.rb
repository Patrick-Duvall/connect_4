


class Board
  attr_accessor :board
  attr_reader :diags
  def initialize
    @board = { a: ['.', '.', '.', '.', '.', '.'], b: ['.', '.', '.', '.', '.', '.'], c: ['.', '.', '.', '.', '.', '.'], d: ['.', '.', '.', '.', '.', '.'], e: ['.', '.', '.', '.', '.', '.'], f: ['.', '.', '.', '.', '.', '.'], g: ['.', '.', '.', '.', '.', '.'] }

    @diags= [[@board[:a][2] , @board[:b][3] , @board[:c][4] , @board[:d][5] ] , [@board[:a][1] , @board[:b][2] , @board[:c][3] , @board[:d][4] , @board[e:][5] ] , [@board[a:][0] , @board[b:][1] , @board[c:][2] , @board[d:][3] , @board[e:][4] , @board[f:][5] ] , [@board[b:][0] , @board[c:][1] , @board[d:][2] , @board[e:][3] , @board[f:][4] , @board[g:][5] ] , [@board[c:][0] , @board[d:][1] , @board[e:][2] , @board[f:][3] , @board[g:][4] ] , [@board[c:][0] , @board[d:][1] , @board[e:][2] , @board[f:][3] ] , [@board[g:][2] , @board[f:][3] , @board[e:][4] , @board[d:][5] ] , [@board[g:][1] , @board[f:][2] , @board[e:][3] , @board[d:][4] , @board[c:][5] ] , [@board[g:][0] , @board[f:][1] , @board[e:][2] , @board[d:][3] , @board[c:][4] , @board[b:][5] ] , [@board[:f][0] , @board[:e][1] , @board[:d][2] , @board[:c][3] , @board[b:][4] , @board[a:][5] ] , [@board[e:][0] , @board[d:][1] , @board[c:][2] , @board[b:][3] , @board[a:][4] ] , [@board[d:][0] , @board[c:][1] , @board[b:][2] , @board[a:][3] ] ]
  end
  def print
    puts "          ABCDEFG
          #{board[:a][5]}#{board[:b][5]}#{board[:c][5]}#{board[:d][5]}#{board[:e][5]}#{board[:f][5]}#{board[:g][5]}
          #{board[:a][4]}#{board[:b][4]}#{board[:c][4]}#{board[:d][4]}#{board[:e][4]}#{board[:f][4]}#{board[:g][4]}
          #{board[:a][3]}#{board[:b][3]}#{board[:c][3]}#{board[:d][3]}#{board[:e][3]}#{board[:f][3]}#{board[:g][3]}
          #{board[:a][2]}#{board[:b][2]}#{board[:c][2]}#{board[:d][2]}#{board[:e][2]}#{board[:f][2]}#{board[:g][2]}
          #{board[:a][1]}#{board[:b][1]}#{board[:c][1]}#{board[:d][1]}#{board[:e][1]}#{board[:f][1]}#{board[:g][1]}
          #{board[:a][0]}#{board[:b][0]}#{board[:c][0]}#{board[:d][0]}#{board[:e][0]}#{board[:f][0]}#{board[:g][0]}"
  end

  def move
    puts "Which column would you like to place in? >"
    move_in_column = gets.chomp
    if move_in_column.match(/[a-g]/i)
      counter = 0
      while @board[move_in_column.downcase.to_sym][counter] != '.'
        counter += 1
      end
      @board[move_in_column.downcase.to_sym][counter] = 'X'
    else
      move
    end
  end

  def comp_move
    move_in_column = ['a', 'b', 'c', 'd', 'e', 'f', 'g'].sample
    counter = 0
    puts move_in_column
    puts @board[move_in_column.to_sym][counter]
    while @board[move_in_column.to_sym][counter] != '.'
        counter += 1
      end
      @board[move_in_column.to_sym][counter] = 'O'

  end

  def wins_vertical?
  possibles = @board.map{|sym, column| column.each_cons(4).to_a}
  p possibles
  possibles.flatten(1).any?{|win_set| win_set ==["X", "X", "X", "X"] || win_set == ["O", "O", "O", "O"]}
  end

  def wins_horizontal?
    arr = []
    count = 0
    6.times do
              arr[count] = @board.map do |sym, col|
              col[count]
            end
            count +=1
    end
    arr = arr.flatten(1).each_cons(4).to_a
    arr.any? {|win_set| win_set == ["X", "X", "X", "X"] || win_set == ["O", "O", "O", "O"]}
  end

  def wins_diagonal?

    p diags
  end


end


board = Board.new
  board.board[:a] = ["X", "X", "O", "X", "X", "O"]
  board.board[:b] = ["X", "X", "O", "X", "X", "O"]
  board.board[:c] = ["X", "X", "O", "X", "X", "O"]
  board.board[:d] = ["X", "X", "O", "X", "X", "O"]
  board.board[:e] = ["X", "X", "X", "X", "X", "O"]
  board.board[:f] = ["X", "X", "O", "X", "X", "O"]
  board.board[:g] = ["X", "X", "O", "X", "X", "O"]
  board.print
  board.wins_diagonal?
