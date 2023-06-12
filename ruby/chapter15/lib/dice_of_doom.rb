Dir.glob(File.expand_path('dice_of_doom/**/*.rb', __dir__)).each do |mod_name|
  require "#{mod_name}"
end

module DiceOfDoom
  NUM_PLAYERS = 2
  MAX_DICE = 3
  BOARD_SIZE = 2
  BOARD_HEXNUM = BOARD_SIZE * BOARD_SIZE
end
