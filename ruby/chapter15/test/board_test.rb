require File.expand_path('../config/application.rb', __dir__)
require 'minitest/autorun'
require './lib/dice_of_doom'

class BoardTest < Minitest::Test
  def test_neighbors
    assert_equal [1, 2], DiceOfDoom::Board.neighbors(0)
    assert_equal [0, 3], DiceOfDoom::Board.neighbors(1)
    assert_equal [0, 3], DiceOfDoom::Board.neighbors(2)
    assert_equal [1, 2], DiceOfDoom::Board.neighbors(3)
  end
end
