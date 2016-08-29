require 'test_helper'

class ApiTest < Minitest::Test

  def setup
    @url = 'http://my.prestashop.com'
    @url_regex = %r{my[.]prestashop[.]com.*}
    @key = 'VALID_KEY'

    xml = File.open(File.join __dir__, 'xml', 'resources.xml').read
    stub_request(:any, @url_regex).to_return body: xml
  end

  def test_get_resources
    resources = Prestashopper::API.new(@url, @key).resources
    assert_equal 3, resources.length
    [:customers, :orders, :products].each {|s| assert_includes resources, s}
  end

  def test_get_products
    xml_products = File.open(File.join __dir__, 'xml', 'products.xml').read
    stub_request(:any, %r{my[.]prestashop[.]com/api/products}).to_return body: xml_products

    products_ids = Prestashopper::API.new(@url, @key).get_products
    assert_equal 2, products_ids.length
    ['1','2'].each {|id| assert_includes products_ids, id}
  end

  def test_get_products_records
    xml_products = File.open(File.join __dir__, 'xml', 'products.xml').read
    stub_request(:any, %r{my[.]prestashop[.]com/api/products}).to_return body: xml_products

    xml_product_1 = File.open(File.join __dir__, 'xml', 'product_1.xml').read
    stub_request(:any, %r{my[.]prestashop[.]com/api/products/1}).to_return body: xml_product_1

    xml_product_2 = File.open(File.join __dir__, 'xml', 'product_2.xml').read
    stub_request(:any, %r{my[.]prestashop[.]com/api/products/2}).to_return body: xml_product_2

    product_ids = Prestashopper::API.new(@url, @key).get_products
    products = Prestashopper::API.new(@url, @key).get_products(product_ids)
    assert_equal 2, products.length
    products_ids = products.map{|p| p['id']}
    ['1','2'].each {|id| assert_includes products_ids, id}
  end
end
