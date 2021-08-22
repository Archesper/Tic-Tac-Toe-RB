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

  # Returns winner's sigil if there is one, 'TIE' if there's a tie, nil otherwise
  def winner_sigil
    return diagonal_win_check if diagonal_win_check
    return horizontal_win_check if horizontal_win_check
    return vertical_win_check if vertical_win_check
    return 'TIE' if @board.count(nil).zero?
  end

  # String representation of the board
  def to_s
    <<-BOARD
     #{cell_to_s(1)} | #{cell_to_s(2)} | #{cell_to_s(3)}
    ---+---+---
     #{cell_to_s(4)} | #{cell_to_s(5)} | #{cell_to_s(6)}
    ---+---+---
     #{cell_to_s(7)} | #{cell_to_s(8)} | #{cell_to_s(9)}
    BOARD
  end

  def put(index, sigil)
    @board[index - 1] = sigil
  end

  private

  # Checks for horizontal win, returns winner's sigil if there is one,
  # nil otherwise
  def horizontal_win_check
    i = 0
    while i <= 6
      if @board[i] == @board[i + 1] && @board[i + 1] == @board[i + 2]
        return @board[i]
      else
        i += 3
      end
    end

    nil
  end

  # Checks for vertical win, returns winner's sigil if there is one,
  # nil otherwise
  def vertical_win_check
    3.times do |i|
      return @board[i] if @board[i] == @board[i + 3] && @board[i + 3] == @board[i + 6]
    end
    nil
  end

  # Checks for diagonal win, returns winner's sigil if there is one,
  # nil otherwise
  def diagonal_win_check
    if (@board[0] == @board[4] && @board[4] == @board[8]) ||
       (@board[2] == @board[4] && @board[4] == @board[6])
      return @board[4]
    end

    nil
  end

  # Returns a string representation of a @board cell - its index if it's empty,
  # its sigil otherwise
  def cell_to_s(index)
    @board[index - 1] || index
  end
end

# Game class
class Game
  attr_accessor :first_player

  def initialize(player1, player2)
    @board = Board.new
    @players = [player1, player2]
    @first_player = @players.sample
  end

  def play
    until @board.winner_sigil
      current_player = @board.next_player(@players[0], @players[1], self)
      Game.player_move(current_player, @board)
      puts '------------------------------------------------------'
    end
    puts @board
    if @board.winner_sigil == 'TIE'
      puts 'Game over, it\'s a tie! Everybody wins!'
    else
      winner = @players.find { |player| player.sigil == @board.winner_sigil }
      puts "#{winner.name} won! Congratulations!"
    end
  end

  def self.player_move(player, board)
    puts board
    puts "It's #{player.name}'s turn, please make your selection (1-9)"
    player_selection = gets.chomp
    until ('1'..'9').include?(player_selection)
      puts 'Please make a valid selection (1-9)'
      player_selection = gets.chomp
    end
    board.put(player_selection.to_i, player.sigil)
  end
end
