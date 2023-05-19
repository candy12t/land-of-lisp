class TextAdventureGame::Graph::Graphviz
  MAX_LABEL_LENGTH = 30

  # @param nodes [Hash<Symbol, Array<String>>]
  # @param edges [Hash<Symbol, Array<String>>]
  def initialize(nodes, edges)
    @nodes = nodes
    @edges = edges
  end

  # @return [Array<String>]
  def nodes_to_dot
    @nodes.map do |node|
      "#{dot_name(node.first)}[label=\"#{dot_lable(node)}\"];"
    end
  end

  # @return [Array<Array<String>>]
  def edges_to_dot
    @edges.map do |key, value|
      value.map do |edge|
        "#{dot_name(key)}->#{dot_name(edge.first)}[label=\"#{dot_lable(edge[1..])}\"];"
      end
    end
  end

  # @return [String]
  def graph_to_dot
    return <<~EOS
      digraph{
      #{nodes_to_dot.join("\n")}
      #{edges_to_dot.join("\n")}
      }
    EOS
  end

  # @param fname [String]
  # @param thunk [Proc]
  def dot_to_png(fname, thunk)
    File.open(fname, "w+") do |f|
      f.write thunk.call
    end
    exec("dot -Tpng -O #{fname}")
  end

  # @param fname [String]
  def graph_to_png(fname)
    dot_to_png(fname, ->() { graph_to_dot })
  end

  # @return [Array<Array<String>>]
  def uedges_to_dot
    keys = @edges.keys
    dots = @edges.map do |key, value|
      dot = []
      value.each do |edge|
        next if keys.include?(edge.first.to_sym)
        dot << "#{dot_name(key)}--#{dot_name(edge.first)}[label=\"#{dot_lable(edge[1..])}\"];"
      end
      keys.delete(key)
      dot
    end
    dots.delete([])
    dots
  end

  # @return [String]
  def ugraph_to_dot
    return <<~EOS
      graph{
      #{nodes_to_dot.join("\n")}
      #{uedges_to_dot.join("\n")}
      }
    EOS
  end

  # @param fname [String]
  def ugraph_to_png(fname)
    dot_to_png(fname, ->() { ugraph_to_dot })
  end

  private

  # @param exp [String, Symbol]
  # @return [String]
  def dot_name(exp)
    exp.to_s.gsub(/[^a-zA-Z0-9]/, '_')
  end

  # @param exp [Array<String>, String]
  # @return [String]
  def dot_lable(exp)
    str = exp.join(' ') if exp.class == Array
    if str.length > MAX_LABEL_LENGTH
      return str[...MAX_LABEL_LENGTH-3] + '...'
    end
    return str
  end
end
