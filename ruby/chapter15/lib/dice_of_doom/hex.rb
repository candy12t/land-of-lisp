module DiceOfDoom
  class Hex

    attr_reader :player, :dice_count

    # @param player [Integer]
    # @param dice_count [Integer]
    def initialize(player, dice_count)
      @player = player
      @dice_count = dice_count
    end

  end
end
