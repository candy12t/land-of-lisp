class TextAdventureGame::Game::Object
  attr_reader :name

  # @param name [String]
  def initialize(name)
    @name = name
  end

  # @return [String]
  def describe_object
    return %W(you see a #{@name} on the floor.).join(' ')
  end
end
