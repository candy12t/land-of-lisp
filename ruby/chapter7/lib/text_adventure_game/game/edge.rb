class TextAdventureGame::Game::Edge
  attr_reader :name, :next_node, :direction, :via

  # @param name [String]
  # @param next_node [String]
  # @param direction [String]
  # @param via [String]
  def initialize(name, next_node, direction, via)
    @name = name
    @next_node = next_node
    @direction = direction
    @via = via
  end
end
