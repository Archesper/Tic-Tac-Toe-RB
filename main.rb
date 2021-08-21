# frozen_string_literal: true

require_relative 'tictactoe'

puts 'What would you (Player 1) like to play as? (X, O, etc...)'
player1 = Player.new(gets, 'Player 1')
puts 'What would you (Player 2) like to play as? (X, O, etc...). You may not' \
" play as #{player1.sigil}:"
sigil2 = gets
while sigil2 == player1.sigil
  puts 'Please pick another sigil'
  sigil2 = gets
end
player2 = Player.new(sigil2, 'Player 2')
