module DiceOfDoom
  class Game

    attr_reader :tree

    def initialize
      # board = Array.new(DiceOfDoom::BOARD_HEXNUM) do |idx|
      #   player = rand(DiceOfDoom::NUM_PLAYERS)
      #   dice_count = rand(DiceOfDoom::MAX_DICE) + 1
      #   DiceOfDoom::Hex.new(player, dice_count)
      # end
      f = ->(p, d) { DiceOfDoom::Hex.get_or_create(player: p, dice_count: d) }
      board = [f.call(0, 3), f.call(0, 3), f.call(1, 3), f.call(1, 1)]
      @tree = DiceOfDoom::Tree.new(board, 0, 0, true)
    end

    def play_vs_human
      print_info
      if @tree.child_tree && !@tree.child_tree.empty?
        handle_human
        play_vs_human
      else
        announce_winner
      end
    end

    def play_vs_computer
      print_info
      if @tree.child_tree.nil? || @tree.child_tree.empty?
        announce_winner
      elsif @tree.player == 0
        handle_human
        play_vs_computer
      else
        handle_computer
        play_vs_computer
      end
    end

    private

    def print_info
      puts
      puts "current player = #{DiceOfDoom::Player.letter(@tree.player)}"
      puts DiceOfDoom::Board.draw(@tree.board)
    end

    def handle_human
      puts
      print "choose your move: "

      @tree.child_tree.each_with_index do |tree, index|
        tree = tree.call
        action = tree.move
        puts
        print "#{index + 1}. "
        if action
          puts "#{action[0]} -> #{action[1]}"
        else
          print "end turn"
        end
      end

      puts
      @tree = @tree.child_tree[gets.chomp.to_i - 1].call
    end

    def handle_computer
      ratings = get_ratings(@tree, @tree.player)
      @tree = tree.child_tree[ratings.index(ratings.max)].call
    end

    def get_ratings(tree, player)
      tree.child_tree.map { |tree| rate_position(tree.call, player) }.flatten
    end

    def rate_position(tree, player)
      if tree.child_tree && !tree.child_tree.empty?
        if tree.player == player
          get_ratings(tree, player).max
        else
          get_ratings(tree, player).min
        end
      else
        w = winners
        if w.include?(player)
          1.0 / w.length
        else
          0
        end
      end
    end

    def winners
      tally = @tree.board.map(&:player)
      totals = tally.uniq.map { |player| [player, tally.count(player)] }
      best = totals.map(&:last).max
      totals.select { |x| x.last == best }.map(&:first)
    end

    def announce_winner
      puts
      w = winners
      if w.length > 1
        puts "The game is a tie between #{w.map { |w| DiceOfDoom::Player.letter(w) }.join(", ")}"
      else
        puts "The winner is #{DiceOfDoom::Player.letter(w.first)}"
      end
    end

  end
end
