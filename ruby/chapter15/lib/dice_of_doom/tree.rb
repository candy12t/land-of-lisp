module DiceOfDoom
  class Tree

    attr_reader :board, :player, :move, :child_tree
    # @param board [Array<DiceOfDoom::Hex>]
    # @param player [Integer]
    # @param spare_dice [Integer]
    # @param fist_move [Boolean]
    # @param move [Array<Integer, Integer>, Nil]
    #
    # child_tree [Array<DiceOfDoom::Tree>]
    def initialize(board, player, spare_dice, first_move, move: nil)
      @board = board
      @player = player
      @spare_dice = spare_dice
      @move = move

      @child_tree = attacking_moves
      @child_tree.unshift(next_turn_tree) unless first_move
    end

    # @return [Array<DiceOfDoom::Tree>]
    def attacking_moves
      (0...DiceOfDoom::BOARD_HEXNUM)
        .select { |src| hex_player(src) == @player }
        .map { |src| attacking_moves_from_src(src) }.flatten
    end

    # @param src [Integer]
    # @return [Array<DiceOfDoom::Tree>]
    def attacking_moves_from_src(src)
      can_attack = ->(dst) { hex_player(dst) && hex_player(dst) != @player && hex_dice(src) > hex_dice(dst) }
      DiceOfDoom::Board.neighbors(src)
        .select { |dst| can_attack.call(dst) }
        .map { |dst| next_turn_tree_after_attack(src, dst)}
    end

    # @return [Array<DiceOfDoom::Hex>]
    def board_attack(src, dst, dice)
      @board.each_with_index.map do |hex, position|
        case position
        when src then DiceOfDoom::Hex.new(@player, 1)
        when dst then DiceOfDoom::Hex.new(@player, dice - 1)
        else hex
        end
      end
    end

    def add_new_dice(spare_dice)
      f = ->(board, dice_count) {
        case
        when board.nil?
          nil
        when dice_count.zero?
          board
        else
          cur_player = board.first.player
          cur_dice = board.first.dice_count
          if cur_player == @player && cur_dice < DiceOfDoom::MAX_DICE
            [DiceOfDoom::Hex.new(cur_player, cur_dice + 1)].concat(f.call(board.drop(1), dice_count - 1))
          else
            [board.first].concat(f.call(board.drop(1), dice_count))
          end
        end
      }

      return f.call(@board.map(&:dup), spare_dice)
    end

    # @return [DiceOfDoom::Tree]
    def next_turn_tree
      board = add_new_dice(@spare_dice - 1)
      player = (@player + 1) % DiceOfDoom::NUM_PLAYERS
      return DiceOfDoom::Tree.new(board, player, 0, true)
    end

    # @return [DiceOfDoom::Tree]
    def next_turn_tree_after_attack(src, dst)
      board = board_attack(src, dst, hex_dice(src))
      spare_dice = @spare_dice + hex_dice(dst)
      return DiceOfDoom::Tree.new(board, @player, spare_dice, false, move: [src, dst])
    end

    private

    # @return [DiceOfDoom::Player]
    def hex_player(position)
      return @board[position].player
    end

    # @return [Integer]
    def hex_dice(position)
      return @board[position].dice_count
    end

  end
end
