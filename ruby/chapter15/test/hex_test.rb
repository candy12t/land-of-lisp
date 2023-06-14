require File.expand_path('../config/application.rb', __dir__)
require 'minitest/autorun'
require './lib/dice_of_doom'

class HexTest < Minitest::Test
  def test_get_or_create
    args = {
      player: 1,
      dice_count: 3
    }
    hex1 = DiceOfDoom::Hex.get_or_create(**args)
    hex2 = DiceOfDoom::Hex.get_or_create(**args)

    assert_equal true, hex1 == hex2
  end
end
