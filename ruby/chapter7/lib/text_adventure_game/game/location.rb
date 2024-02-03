class TextAdventureGame::Game::Location
  attr_reader :name, :node, :edges, :objects

  # @param name [String]
  # @param node [TextAdventureGame::Game::Node]
  # @param edges [Array<TextAdventureGame::Game::Node>]
  # @option objects [Array<TextAdventureGame::Game::Node>]
  def initialize(name, node, edges, objects = [])
    @name = name
    @node = node
    @edges = edges
  end
end
