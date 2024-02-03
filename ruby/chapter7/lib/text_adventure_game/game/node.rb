class TextAdventureGame::Game::Node
  attr_reader :name, :view

  # @param name [String]
  # @param view [Array<String>]
  def initialize(name, view)
    @name = name
    @view = view
  end
end
