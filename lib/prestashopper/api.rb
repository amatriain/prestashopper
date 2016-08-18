module Prestashopper

  # Each instance represents a Prestashop API instance.
  class API

    # @return [String] URI of the Prestashop API
    attr_reader :api_uri

    # @return [String] API key
    attr_reader :key

    # Create a new instance
    # @param url [String] base URL of the Prestashop installation. Do not append "/api" to it, the gem does it internally.
    #   E.g. use "http://my.prestashop.com", not "http://my.prestashop.com/api"
    # @param key [String] a valid API key
    def initialize(url, key)
      @api_uri = UriHandler.api_uri url
      @key = key
      @resources_res = RestClient::Resource.new @api_uri, user: @key, password: ''
    end

    # List resources that the API key can access
    # @return [Array<Symbol>] list of resources the API can access
    def resources
      xml = @resources_res.get.body
      xml_doc = Nokogiri::XML xml
      nodes = xml_doc.xpath '/prestashop/api/*'
      resources_list = []
      nodes.each{|n| resources_list << n.name.to_sym}
      return resources_list
    end

    # Get all products data
    # @return [Array<Hash>] list of products. Each product is represented by a hash with all its attributes.
    def get_products
      # /api/products returns XML with the IDs of each individual product
      xml_products = @resources_res['products'].get.body
      xml_products_doc = Nokogiri::XML xml_products
      products_nodes = xml_products_doc.xpath '/prestashop/products/*/@id'
      ids_list = []
      products_nodes.each{|n| ids_list << n.value}

      # GET each individual product to get the whole data
      products = []
      ids_list.each do |id|
        xml_product = @resources_res["products/#{id}"].get.body
        product = Product.xml2hash xml_product
        products << product
      end

      return products
    end
  end
end
