module DiceOfDoom
  class Player

    class << self
      # @param id [Integer]
      # @return [String]
      def letter(id)
        (id + 'A'.ord).chr
      end
    end

  end
end
