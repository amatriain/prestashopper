require 'test_helper'

class PrestashopperTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Prestashopper::VERSION
  end

  def test_checks_valid_key
    p = Prestashopper::API.new
    key = 'invalid_key'
    assert_equal p.valid_key?(key), false
  end
end
