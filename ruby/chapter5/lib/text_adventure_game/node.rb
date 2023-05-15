class TextAdventureGame::Node
  attr_reader :location, :edges, :objects

  # @param location [TextAdventureGame::Location]
  # @param edges [Array<TextAdventureGame::Edge>]
  # @param objects [Array<TextAdventureGame::Object>]
  def initialize(location, edges, objects)
    @location = location
    @edges = edges
    @objects = objects
  end

  # @param direction [String]
  # @return [TextAdventureGame::Edge]
  def find_edge(direction)
    return @edges.find { |edge| edge.direction == direction }
  end

  # @param name [String]
  # @return [TextAdventureGame::Object]
  def find_object(name)
    return @objects.find { |object| object.name == name }
  end
end
