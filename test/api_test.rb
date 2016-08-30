require 'test_helper'

class ApiTest < Minitest::Test

  def setup
    @url = 'http://my.prestashop.com'
    @url_regex = %r{my[.]prestashop[.]com.*}
    @key = 'VALID_KEY'
    @resources = [:customers, :orders, :products]
    @product_ids = ['1', '2']

    xml = File.open(File.join __dir__, 'xml', 'resources.xml').read
    stub_request(:any, @url_regex).to_return body: xml

    xml_products = File.open(File.join __dir__, 'xml', 'products.xml').read
    stub_request(:any, %r{my[.]prestashop[.]com/api/products}).to_return body: xml_products

    xml_product_1 = File.open(File.join __dir__, 'xml', 'product_1.xml').read
    stub_request(:any, %r{my[.]prestashop[.]com/api/products/1}).to_return body: xml_product_1

    xml_product_2 = File.open(File.join __dir__, 'xml', 'product_2.xml').read
    stub_request(:any, %r{my[.]prestashop[.]com/api/products/2}).to_return body: xml_product_2
  end

  def test_get_resources
    resources = Prestashopper::API.new(@url, @key).resources
    assert_equal @resources.length, resources.length
    @resources.each { |resource| assert_includes resources, resource }
  end

  def test_get_products
    products_ids = Prestashopper::API.new(@url, @key).get_products
    assert_equal @product_ids.length, products_ids.length
    @product_ids.each { |id| assert_includes products_ids, id }
  end

  def test_get_products_for_ids
    products = Prestashopper::API.new(@url, @key).get_products(*@product_ids)
    assert_equal @product_ids.length, products.length
    products_ids = products.collect(&:id)
    @product_ids.each { |id| assert_includes products_ids, id }
    products.each { |product| assert_kind_of Prestashopper::Product, product }
  end

  def test_get_product_for_id
    product_id = @product_ids.first
    product = Prestashopper::API.new(@url, @key).get_product(product_id)
    assert_kind_of Prestashopper::Product, product
    assert_equal product.id, product_id
  end
end
