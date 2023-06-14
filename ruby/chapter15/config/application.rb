require 'yaml'

conf = YAML.load_file(File.expand_path('./dice_of_doom.yaml', __dir__))
env = ENV.fetch('APP_ENV', 'default')

NUM_PLAYERS = conf[env]['num_players']
MAX_DICE = conf[env]['max_dice']
BOARD_SIZE = conf[env]['board_size']
BOARD_HEXNUM = BOARD_SIZE ** 2
