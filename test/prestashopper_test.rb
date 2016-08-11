require 'test_helper'

class PrestashopperTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Prestashopper::VERSION
  end

  def test_checks_invalid_key
    url = 'https://my.prestashop.com'
    key = 'invalid_key'
    assert_equal Prestashopper.valid_key?(url, key), false
  end
end
