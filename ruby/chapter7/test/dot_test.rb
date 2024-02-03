require 'minitest/autorun'
require './lib/dot'

class DotTest < Minitest::Test
  def setup
    @dot = Dot.new
  end

  def test_dot_name
    assert_equal 'living_room', @dot.dot_name('living-room')
    assert_equal 'foo_', @dot.dot_name('foo!')
    assert_equal '24', @dot.dot_name('24')
  end
end
