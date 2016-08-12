require 'test_helper'

class PrestashopperTest < Minitest::Test

  def setup
    @url = 'http://my.prestashop.com'
    @url_regex = %r{my[.]prestashop[.]com.*}
  end

  def test_that_it_has_a_version_number
    refute_nil ::Prestashopper::VERSION
  end

  def test_checks_api_enabled
    web_stub = stub_request(:any, @url_regex).to_return status: 503
    assert_equal Prestashopper.api_enabled?(@url), false

    remove_request_stub web_stub
    stub_request(:any, @url_regex).to_return status: 401
    assert_equal Prestashopper.api_enabled?(@url), true
  end

  def test_raises_error_checking_api_enabled
    stub_request(:any, @url_regex).to_return status: 200
    assert_raises(StandardError) {Prestashopper.api_enabled? @url}
  end

  def test_checks_valid_key
    stub_request(:any, @url_regex).to_return status: 200
    assert_equal Prestashopper.valid_key?(@url, 'valid_key'), true
  end

  def test_checks_invalid_key
    stub_request(:any, @url_regex).to_return status: 401
    assert_equal Prestashopper.valid_key?(@url, 'invalid_key'), false
  end

  def test_raises_error_checking_key_valid
    stub_request(:any, @url_regex).to_return status: 500
    assert_raises(StandardError) {Prestashopper.api_enabled? @url}
  end
end
