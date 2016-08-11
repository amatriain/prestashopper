require 'test_helper'

class PrestashopperTest < Minitest::Test

  def setup
    @web_stub = stub_request(:any, %r{my.prestashop.com.*})
    @url = 'http://my.prestashop.com'
  end

  def test_that_it_has_a_version_number
    refute_nil ::Prestashopper::VERSION
  end

  def test_checks_api_enabled
    remove_request_stub @web_stub
    web_stub = stub_request(:any, %r{my.prestashop.com.*}).to_return status: 503
    assert_equal Prestashopper.api_enabled?(@url), false

    remove_request_stub web_stub
    web_stub = stub_request(:any, %r{my.prestashop.com.*}).to_return status: 401
    assert_equal Prestashopper.api_enabled?(@url), true
  end

  def test_checks_invalid_key
    key = 'invalid_key'
    assert_equal Prestashopper.valid_key?(@url, key), false
  end

  def test_checks_valid_key
    skip
    key = 'valid_key'
    assert_equal Prestashopper.valid_key?(@url, key), true
  end
end
