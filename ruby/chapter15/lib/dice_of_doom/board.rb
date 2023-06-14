module DiceOfDoom
  class Board

    @@positions = {}

    class << self

      # @param board [Array<DiceOfDoom::Hex>]
      # @return [String]
      def draw(board)
        message = ""
        board.each_slice(BOARD_SIZE).with_index do |row, idx|
          message += "\s\s" * (BOARD_SIZE - idx)
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
        return @@positions[pos] ||= calculate_neighbors(pos)
      end

      private

      def calculate_neighbors(pos)
        up = pos - BOARD_SIZE
        down = pos + BOARD_SIZE

        positions = [up, down]
        positions << pos + 1 unless pos % BOARD_SIZE == BOARD_SIZE - 1
        positions << pos - 1 unless pos % BOARD_SIZE == 0

        return positions.sort.select { |p| p >= 0 && p < BOARD_HEXNUM }
      end

    end

  end
end
