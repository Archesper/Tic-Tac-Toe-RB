# frozen_string_literal: false

# Player class
class Player
  attr_reader :sigil, :name

  def initialize(sigil, name)
    @sigil = sigil
    @name = name
  end
end
