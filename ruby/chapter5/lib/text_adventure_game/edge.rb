class TextAdventureGame::Edge
  attr_reader :next_location, :direction, :via

  # @param next_location [TextAdventureGame::Location]
  # @param direction [String]
  # @param via [String]
  def initialize(next_location, direction, via)
    @next_location = next_location
    @direction = direction
    @via = via
  end

  # @return [String]
  def describe_path
    return %W(there is a #{@via} going #{@direction} from here.).join(' ')
  end
end
