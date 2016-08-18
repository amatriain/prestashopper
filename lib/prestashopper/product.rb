require 'active_support/core_ext/hash'

module Prestashopper

  # Has methods to convert the XML returned from the API to a ruby hash
  class Product

    # Convert a product XML returned by the Prestashop API to a ruby hash, more manageable
    # @param xml [String] XML returned by the Prestashop API
    # @return [Hash] the product converted to a hash representation
    def self.xml2hash(xml)
      xml_doc = Nokogiri::XML( xml).remove_namespaces!
      # Strip surrounding tag
      nodes = xml_doc.xpath '/prestashop/*'
      product_xml = nodes.to_s
      product_hash = Hash.from_xml product_xml

      return product_hash['product']
    end
  end
end
