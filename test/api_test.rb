require 'test_helper'

class ApiTest < Minitest::Test

  def setup
    @url = 'http://my.prestashop.com'
    @url_regex = %r{my[.]prestashop[.]com.*}
    @key = 'VALID_KEY'
  end

  def test_get_resources
    xml = <<-EOS
      <?xml version="1.0" encoding="UTF-8"?>
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
    assert_equal 3, resources.length
    [:customers, :orders, :products].each {|s| assert_includes resources, s}
  end

  def test_get_products
    xml_products = <<-EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
        <products>
          <product id="397" xlink:href="https://my.prestashop.com/api/products/397"/>
          <product id="463" xlink:href="https://my.prestashop.com/api/products/463"/>
        </products>
      </prestashop>
    EOS
    stub_request(:any, %r{my[.]prestashop[.]com/api/products}).to_return body: xml_products

    xml_product_397 = <<-EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
        <product>
          <id><![CDATA[397]]></id>
          <id_manufacturer><![CDATA[0]]></id_manufacturer>
          <id_supplier><![CDATA[0]]></id_supplier>
          <id_category_default xlink:href="https://my.prestashop.com/api/categories/2"><![CDATA[2]]></id_category_default>
          <new></new>
          <cache_default_attribute><![CDATA[0]]></cache_default_attribute>
          <id_default_image xlink:href="https://my.prestashop.com/api/images/products/397/463" notFilterable="true"><![CDATA[463]]></id_default_image>
          <id_default_combination notFilterable="true"></id_default_combination>
          <id_tax_rules_group xlink:href="https://my.prestashop.com/api/tax_rule_groups/1"><![CDATA[1]]></id_tax_rules_group>
          <position_in_category notFilterable="true"><![CDATA[0]]></position_in_category>
          <manufacturer_name notFilterable="true"></manufacturer_name>
          <quantity notFilterable="true"><![CDATA[0]]></quantity>
          <type notFilterable="true"><![CDATA[simple]]></type>
          <id_shop_default><![CDATA[1]]></id_shop_default>
          <reference><![CDATA[X54000]]></reference>
          <supplier_reference></supplier_reference>
          <location></location>
          <width><![CDATA[0.000000]]></width>
          <height><![CDATA[0.000000]]></height>
          <depth><![CDATA[0.000000]]></depth>
          <weight><![CDATA[0.000000]]></weight>
          <quantity_discount><![CDATA[0]]></quantity_discount>
          <ean13><![CDATA[4211125954000]]></ean13>
          <upc></upc>
          <cache_is_pack><![CDATA[0]]></cache_is_pack>
          <cache_has_attachments><![CDATA[0]]></cache_has_attachments>
          <is_virtual><![CDATA[0]]></is_virtual>
          <on_sale><![CDATA[0]]></on_sale>
          <online_only><![CDATA[0]]></online_only>
          <ecotax><![CDATA[0.000000]]></ecotax>
          <minimal_quantity><![CDATA[1]]></minimal_quantity>
          <price><![CDATA[24.710744]]></price>
          <wholesale_price><![CDATA[0.000000]]></wholesale_price>
          <unity></unity>
          <unit_price_ratio><![CDATA[0.000000]]></unit_price_ratio>
          <additional_shipping_cost><![CDATA[0.00]]></additional_shipping_cost>
          <customizable><![CDATA[0]]></customizable>
          <text_fields><![CDATA[0]]></text_fields>
          <uploadable_files><![CDATA[0]]></uploadable_files>
          <active><![CDATA[0]]></active>
          <redirect_type><![CDATA[404]]></redirect_type>
          <id_product_redirected><![CDATA[0]]></id_product_redirected>
          <available_for_order><![CDATA[1]]></available_for_order>
          <available_date><![CDATA[0000-00-00]]></available_date>
          <condition><![CDATA[new]]></condition>
          <show_price><![CDATA[1]]></show_price>
          <indexed><![CDATA[0]]></indexed>
          <visibility><![CDATA[both]]></visibility>
          <advanced_stock_management><![CDATA[0]]></advanced_stock_management>
          <date_add><![CDATA[2014-11-21 19:18:34]]></date_add>
          <date_upd><![CDATA[2015-12-10 13:31:03]]></date_upd>
          <pack_stock_type><![CDATA[3]]></pack_stock_type>
          <meta_description><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></meta_description>
          <meta_keywords><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></meta_keywords>
          <meta_title><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></meta_title>
          <link_rewrite><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[product-397jby-52-river]]></language></link_rewrite>
          <name><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[product 397]]></language></name>
          <description><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[<p>product 397</p>]]></language></description>
          <description_short><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[<p>product 397</p>]]></language></description_short>
          <available_now><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></available_now>
          <available_later><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></available_later>
        <associations>
        <categories nodeType="category" api="categories">
          <category xlink:href="https://my.prestashop.com/api/categories/2">
          <id><![CDATA[2]]></id>
          </category>
        </categories>
        <images nodeType="image" api="images">
          <image xlink:href="https://my.prestashop.com/api/images/products/397/463">
          <id><![CDATA[463]]></id>
          </image>
        </images>
        <combinations nodeType="combination" api="combinations"/>
        <product_option_values nodeType="product_option_value" api="product_option_values"/>
        <product_features nodeType="product_feature" api="product_features"/>
        <tags nodeType="tag" api="tags"/>
        <stock_availables nodeType="stock_available" api="stock_availables">
          <stock_available xlink:href="https://my.prestashop.com/api/stock_availables/556">
          <id><![CDATA[556]]></id>
          <id_product_attribute><![CDATA[0]]></id_product_attribute>
          </stock_available>
        </stock_availables>
        <accessories nodeType="product" api="products"/>
        <product_bundle nodeType="product" api="products"/>
        </associations>
        </product>
      </prestashop>
    EOS
    stub_request(:any, %r{my[.]prestashop[.]com/api/products/397}).to_return body: xml_product_397

    xml_product_463 = <<-EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <prestashop xmlns:xlink="http://www.w3.org/1999/xlink">
        <product>
          <id><![CDATA[463]]></id>
          <id_manufacturer><![CDATA[0]]></id_manufacturer>
          <id_supplier><![CDATA[0]]></id_supplier>
          <id_category_default xlink:href="https://my.prestashop.com/api/categories/2"><![CDATA[2]]></id_category_default>
          <new></new>
          <cache_default_attribute><![CDATA[0]]></cache_default_attribute>
          <id_default_image notFilterable="true"></id_default_image>
          <id_default_combination notFilterable="true"></id_default_combination>
          <id_tax_rules_group xlink:href="https://my.prestashop.com/api/tax_rule_groups/1"><![CDATA[1]]></id_tax_rules_group>
          <position_in_category notFilterable="true"><![CDATA[1]]></position_in_category>
          <manufacturer_name notFilterable="true"></manufacturer_name>
          <quantity notFilterable="true"><![CDATA[0]]></quantity>
          <type notFilterable="true"><![CDATA[simple]]></type>
          <id_shop_default><![CDATA[1]]></id_shop_default>
          <reference><![CDATA[S0002028]]></reference>
          <supplier_reference></supplier_reference>
          <location></location>
          <width><![CDATA[0.000000]]></width>
          <height><![CDATA[0.000000]]></height>
          <depth><![CDATA[0.000000]]></depth>
          <weight><![CDATA[750.000000]]></weight>
          <quantity_discount><![CDATA[0]]></quantity_discount>
          <ean13><![CDATA[8420341402028]]></ean13>
          <upc></upc>
          <cache_is_pack><![CDATA[0]]></cache_is_pack>
          <cache_has_attachments><![CDATA[0]]></cache_has_attachments>
          <is_virtual><![CDATA[0]]></is_virtual>
          <on_sale><![CDATA[0]]></on_sale>
          <online_only><![CDATA[0]]></online_only>
          <ecotax><![CDATA[0.000000]]></ecotax>
          <minimal_quantity><![CDATA[1]]></minimal_quantity>
          <price><![CDATA[0.000000]]></price>
          <wholesale_price><![CDATA[0.000000]]></wholesale_price>
          <unity></unity>
          <unit_price_ratio><![CDATA[0.000000]]></unit_price_ratio>
          <additional_shipping_cost><![CDATA[0.00]]></additional_shipping_cost>
          <customizable><![CDATA[0]]></customizable>
          <text_fields><![CDATA[0]]></text_fields>
          <uploadable_files><![CDATA[0]]></uploadable_files>
          <active><![CDATA[0]]></active>
          <redirect_type><![CDATA[404]]></redirect_type>
          <id_product_redirected><![CDATA[0]]></id_product_redirected>
          <available_for_order><![CDATA[1]]></available_for_order>
          <available_date><![CDATA[0000-00-00]]></available_date>
          <condition><![CDATA[new]]></condition>
          <show_price><![CDATA[1]]></show_price>
          <indexed><![CDATA[0]]></indexed>
          <visibility><![CDATA[both]]></visibility>
          <advanced_stock_management><![CDATA[0]]></advanced_stock_management>
          <date_add><![CDATA[2014-12-31 12:56:53]]></date_add>
          <date_upd><![CDATA[2015-12-10 13:31:33]]></date_upd>
          <pack_stock_type><![CDATA[3]]></pack_stock_type>
          <meta_description><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></meta_description>
          <meta_keywords><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></meta_keywords>
          <meta_title><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></meta_title>
          <link_rewrite><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[product-463]]></language></link_rewrite>
          <name><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[product 463]]></language></name>
          <description><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></description>
          <description_short><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></description_short>
          <available_now><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></available_now>
          <available_later><language id="1" xlink:href="https://my.prestashop.com/api/languages/1"><![CDATA[]]></language></available_later>
        <associations>
        <categories nodeType="category" api="categories">
          <category xlink:href="https://my.prestashop.com/api/categories/2">
          <id><![CDATA[2]]></id>
          </category>
        </categories>
        <images nodeType="image" api="images"/>
        <combinations nodeType="combination" api="combinations"/>
        <product_option_values nodeType="product_option_value" api="product_option_values"/>
        <product_features nodeType="product_feature" api="product_features"/>
        <tags nodeType="tag" api="tags"/>
        <stock_availables nodeType="stock_available" api="stock_availables">
          <stock_available xlink:href="https://my.prestashop.com/api/stock_availables/627">
          <id><![CDATA[627]]></id>
          <id_product_attribute><![CDATA[0]]></id_product_attribute>
          </stock_available>
        </stock_availables>
        <accessories nodeType="product" api="products"/>
        <product_bundle nodeType="product" api="products"/>
        </associations>
        </product>
      </prestashop>
    EOS
    stub_request(:any, %r{my[.]prestashop[.]com/api/products/463}).to_return body: xml_product_463

    products = Prestashopper::API.new(@url, @key).get_products
    assert_equal 2, products.length
    # TODO rest of assertions
  end
end
