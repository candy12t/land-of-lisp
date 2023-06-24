module DiceOfDoom
  class Hex

    @@cache = Hash.new { |h, k| h[k] = Hash.new }
    attr_reader :player, :dice_count
    private_class_method :new

    # @param player [Integer]
    # @param dice_count [Integer]
    def initialize(player, dice_count)
      @player = player
      @dice_count = dice_count
    end

    class << self
      def get_or_create(player:, dice_count:)
        dices = @@cache[player]
        dices[dice_count] ||= new(player, dice_count)
      end
    end

  end
end
