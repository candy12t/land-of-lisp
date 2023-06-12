module DiceOfDoom
  class Game

    attr_reader :tree

    def initialize
      board = Array.new(DiceOfDoom::BOARD_HEXNUM) do |idx|
        player = rand(DiceOfDoom::NUM_PLAYERS)
        dice_count = rand(DiceOfDoom::MAX_DICE) + 1
        DiceOfDoom::Hex.new(player, dice_count)
      end
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

    def print_info
      puts
      puts "current player = #{DiceOfDoom::Player.letter(@tree.player)}"
      puts @tree.draw
    end

    def handle_human
      puts
      print "choose your move: "
      trees = @tree.child_tree

      trees.each_with_index do |tree, index|
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
      @tree = trees[gets.chomp.to_i - 1]
    end

    def winners
      tally = @tree.board.map(&:player)
      totals = tally.uniq.map { |player| [player, tally.count(player)] }
      best = totals.map(&:last).max
      totals.select { |x| x.last == best }.map(&:first)
    end

    def announce_winner
      puts
      if winners.length > 1
        puts "The game is a tie between #{winners.map { |w| DiceOfDoom::Player.letter(w) }.join(", ")}"
      else
        puts "The winner is #{DiceOfDoom::Player.letter(winners.first)}"
      end
    end

  end
end
