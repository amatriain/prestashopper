require 'test_helper'

class ApiTest < Minitest::Test

  def setup
    @url = 'http://my.prestashop.com'
    @url_regex = %r{my[.]prestashop[.]com.*}
    @key = 'VALID_KEY'
  end

  def test_get_resources
    xml = <<-EOS
      <prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
        <api shopName="MyPrestashop">
          <customers xlink:href="http://my.prestashop.com/api/customers" get="true" put="false" post="false" delete="false" head="true">
            <description xlink:href="http://my.prestashop.com/api/customers" get="true" put="false" post="false" delete="false" head="true">The e-shop's customers</description>
            <schema xlink:href="http://my.prestashop.com/api/customers?schema=blank" type="blank"/>
            <schema xlink:href="http://my.prestashop.com/api/customers?schema=synopsis" type="synopsis"/>
          </customers>
          <orders xlink:href="http://my.prestashop.com/api/orders" get="true" put="false" post="false" delete="false" head="true">
            <description xlink:href="http://my.prestashop.com/api/orders" get="true" put="false" post="false" delete="false" head="true">The Customers orders</description>
            <schema xlink:href="http://my.prestashop.com/api/orders?schema=blank" type="blank"/>
            <schema xlink:href="http://my.prestashop.com/api/orders?schema=synopsis" type="synopsis"/>
          </orders>
          <products xlink:href="http://my.prestashop.com/api/products" get="true" put="false" post="false" delete="false" head="true">
            <description xlink:href="http://my.prestashop.com/api/products" get="true" put="false" post="false" delete="false" head="true">The products</description>
            <schema xlink:href="http://my.prestashop.com/api/products?schema=blank" type="blank"/>
            <schema xlink:href="http://my.prestashop.com/api/products?schema=synopsis" type="synopsis"/>
          </products>
        </api>
      </prestashop>
    EOS
    stub_request(:any, @url_regex).to_return body: xml

    resources = Prestashopper::API.new(@url, @key).resources
    assert_equal resources.length, 3
    [:customers, :orders, :products].each {|s| assert_includes resources, s}
  end
end
