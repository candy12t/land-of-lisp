$location = :living_room

$nodes = {
  living_room: %w(you are in the living-room. a wizard is snoring loudly on the couch.),
  garden: %w(you are in a beautiful garden. there is a well in front of you.),
  attic: %w(you are in the attic. there is a giant welding torch in the corner.),
}

$edges = {
  living_room: [%i(garden west door), %i(attic upstairs ladder)],
  garden: [%i(living_room east door)],
  attic: [%i(living_room downstairs ladder)],
}

$objects = %i(whiskey bucket frog chain)

$object_locations = {
  whiskey: :living_room,
  bucket: :living_room,
  chain: :garden,
  frog: :garden,
}

def describe_location(location, nodes)
  return nodes[location.to_sym]
end

def describe_path(edge)
  return %W(there is a #{edge[2]} going #{edge[1]} from here.)
end

def describe_paths(location, edges)
  return edges[location.to_sym].map { |edge| describe_path(edge) }.flatten
end

def object_at(location, objects, object_locations)
  at_local = ->(object) { object_locations[object.to_sym] == location.to_sym }
  return objects.select(&at_local)
end

def describe_objects(location, objects, object_locations)
  describe_object = ->(object) { %W(you see a #{object} on the floor.) }
  return object_at(location, objects, object_locations).map(&describe_object)
end

def look
  array = []
  array.push(
    describe_location($location, $nodes),
    describe_paths($location, $edges),
    describe_objects($location, $objects, $object_locations),
  ).flatten
end

def walk(direction)
  next_to = $edges[$location].find {|edge| edge.include?(direction.to_sym) }
  if next_to
    $location = next_to[0]
    return look
  else
    return %w(you cannot go that way.)
  end
end

def pickup(object)
  if object_at($location, $objects, $object_locations).include?(object.to_sym)
    $object_locations[object.to_sym] = :body
    %W(you are now carrying the #{object})
  else
    %w(you cannot get that.)
  end
end

def inventory
  return %W(items- #{object_at(:body, $objects, $object_locations)})
end

p describe_location($location, $nodes)
p describe_path($edges[$location].first)
p describe_paths($location, $edges)
p object_at($location, $objects, $object_locations)
p describe_objects($location, $objects, $object_locations).flatten
p look
p walk(:west)
p pickup(:chain)
p inventory
