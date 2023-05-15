class TextAdventureGame::World
  attr_reader :nodes

  def initialize
    living_room = TextAdventureGame::Location.new('living_room', %w(you are in the living-room. a wizard is snoring loudly on the couch.))
    garden = TextAdventureGame::Location.new('garden', %w(you are in a beautiful garden. there is a well in front of you.))
    attic = TextAdventureGame::Location.new('attic', %w(you are in the attic. there is a giant welding torch in the corner.))

    whiskey = TextAdventureGame::Object.new('whiskey')
    bucket = TextAdventureGame::Object.new('bucket')
    frog = TextAdventureGame::Object.new('frog')
    chain = TextAdventureGame::Object.new('chain')

    @nodes = {}
    @nodes[:living_room] = TextAdventureGame::Node.new(
      living_room,
      [TextAdventureGame::Edge.new(garden, 'west', 'door'), TextAdventureGame::Edge.new(attic, 'upstairs', 'ladder')],
      [whiskey, bucket]
    )
    @nodes[:garden] = TextAdventureGame::Node.new(
      garden,
      [TextAdventureGame::Edge.new(living_room, 'east', 'door')],
      [chain, frog]
    )
    @nodes[:attic] = TextAdventureGame::Node.new(
      attic,
      [TextAdventureGame::Edge.new(living_room, 'downstairs', 'ladder')],
      []
    )
  end

  # @param location [String, Symbol]
  # @return [String]
  def describe_location(location)
    return location(location).view.join(' ')
  end

  # @param location [String, Symbol]
  # @return [String]
  def describe_paths(location)
    return edges(location).map { |edge| edge.describe_path }.join("\n")
  end

  # @param location [String, Symbol]
  # @return [String]
  def describe_objects(location)
    return objects(location).map { |object| object.describe_object }.join("\n")
  end

  # @param location [String, Symbol]
  # @return [TextAdventureGame::Node]
  def node(location)
    return nodes[location.to_sym]
  end

  # @param location [String, Symbol]
  # @return [TextAdventureGame::Location]
  def location(location)
    return node(location).location
  end

  # @param location [String, Symbol]
  # @return [Array<TextAdventureGame::Edge>]
  def edges(location)
    return node(location).edges
  end

  # @param location [String, Symbol]
  # @return [Array<TextAdventureGame::Object>]
  def objects(location)
    return node(location).objects
  end
end
