class TextAdventureGame::Player
  attr_reader :location, :items

  # @param world [TextAdventureGame::World]
  # @param location [String]
  # @option items [Array<TextAdventureGame::Object>]
  def initialize(world, location, items = [])
    @world = world
    @location = location
    @items = items
  end

  # @return [String]
  def look
    views = []
    views.push(
      @world.describe_location(@location),
      @world.describe_paths(@location),
      @world.describe_objects(@location),
    )
    return views.join("\n")
  end

  # @param direction [String]
  # @return [String]
  def walk(direction)
    next_to = @world.node(@location).find_edge(direction)
    if next_to
      @location = next_to.next_location.name
      return look
    else
      return %w(you cannot go that way.).join(' ')
    end
  end

  # @param object [String]
  # @return [String]
  def pickup(object)
    obj = @world.node(@location).find_object(object)
    if obj
      @items << obj
      @world.objects(@location).delete(obj)
      return %W(you are now carrying the #{obj.name}).join(' ')
    else
      return %w(you cannot get that.).join(' ')
    end
  end

  # @return [String]
  def inventory
    return %W(items- #{@items.map { |item| item.name }.join(' ')}).join(' ')
  end
end
