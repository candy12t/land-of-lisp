module DiceOfDoom
  class Board

    class << self

      # @param board [Array<DiceOfDoom::Hex>]
      # @return [String]
      def draw(board)
        message = ""
        board.each_slice(DiceOfDoom::BOARD_SIZE).with_index do |row, idx|
          message += "\s\s" * (DiceOfDoom::BOARD_SIZE - idx)
          row.each do |hex|
            message += "#{DiceOfDoom::Player.letter(hex.player)}-#{hex.dice_count} "
          end
          message += "\n"
        end
        return message
      end

      # @param pos [Integer]
      # @return [Array<Integer>]
      def neighbors(pos)
        up = pos - DiceOfDoom::BOARD_SIZE
        down = pos + DiceOfDoom::BOARD_SIZE

        positions = [up, down]
        positions << pos + 1 unless pos % DiceOfDoom::BOARD_SIZE == DiceOfDoom::BOARD_SIZE - 1
        positions << pos - 1 unless pos % DiceOfDoom::BOARD_SIZE == 0

        return positions.sort.select { |p| p >= 0 && p < DiceOfDoom::BOARD_HEXNUM }
      end

    end

  end
end
