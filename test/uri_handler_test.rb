require 'test_helper'

class UriHandlerTest < Minitest::Test

  def test_get_api_uri
    base_uri = 'http://my.prestashop.com'
    expected_uri = URI.parse 'http://my.prestashop.com/api/'
    api_uri = Prestashopper::UriHandler.api_uri base_uri
    assert_equal api_uri, expected_uri
  end

  def test_get_api_uri_with_path
    base_uri = 'http://my.prestashop.com/prestashop'
    expected_uri = URI.parse 'http://my.prestashop.com/prestashop/api/'
    api_uri = Prestashopper::UriHandler.api_uri base_uri
    assert_equal api_uri, expected_uri
  end
end