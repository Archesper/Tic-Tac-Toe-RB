# frozen_string_literal: true

require_relative 'tictactoe'

# Helper method to check if a string is numeric
def numeric_string?(string)
  if string.to_f != 0.0 || (string.to_i.zero? && ['0', '0.0'].include?(string))
    true
  else
    false
  end
end

puts 'What would you (Player 1) like to play as? (X, O, etc...)' \
     ' You may not pick a number.'
sigil1 = gets.chomp[0]
while numeric_string?(sigil1)
  puts 'You may not pick a number'
  sigil1 = gets.chomp[0]
end
player1 = Player.new(sigil1, 'Player 1')
puts 'What would you (Player 2) like to play as? (X, O, etc...). You may not' \
 " play as '#{player1.sigil}'.".chomp
sigil2 = gets.chomp
while sigil2 == (player1.sigil) || numeric_string?(sigil2)
  puts numeric_string?(sigil2) ? 'You may not pick a number:' : 'Please pick another character:'
  sigil2 = gets.chomp
end
player2 = Player.new(sigil2, 'Player 2')

game = Game.new(player1, player2)
