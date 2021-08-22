# frozen_string_literal: false

# Player class
class Player
  attr_reader :sigil, :name

  def initialize(sigil, name)
    @sigil = sigil
    @name = name
  end
end

# Board class
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9)
  end

  # Returns the next player to make a move
  def next_player(player1, player2, game)
    player1_moves = @board.count player1.sigil
    player2_moves = @board.count player2.sigil
    if player1_moves < player2_moves
      player1
    elsif player1_moves > player2_moves
      player2
    else
      game.first_player
    end
  end

  # Returns winner's sigil if there is one, nil otherwise
  def winner_sigil
    # Vertical check
    3.times do |i|
      if board[i] == board[i + 3] && board[i + 3] == board[i + 6]
        return board[i]
      end
    end
    # Horizontal check
    i = 0
    while i <= 6
      if board[i] == board[i + 1] && board[i + 1] == board[i + 2]
        return board[i]
      else
        i += 3
      end
    end
    # Diagonal check
    if (board[0] == board[4] && board[4] == board[8]) ||
       (board[2] == board[4] && board[4] == board[6])
      board[4]
    end
  end
end
