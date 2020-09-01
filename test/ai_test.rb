require './test/test_helper'

class AITest < Minitest::Test
  def setup
    @ai = AI.new
  end

  def test_it_exists
    assert_instance_of AI, @ai
  end

end
