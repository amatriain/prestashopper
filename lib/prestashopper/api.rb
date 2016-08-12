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
    end

    # List resources that the API key can access
    # @return [Array<Symbol>] list of resources the API can access
    def resources
      @resources_res ||= RestClient::Resource.new @api_uri, user: @key, password: ''
      xml = @resources_res.get.body
      xml_doc = Nokogiri::XML xml
      nodes = xml_doc.xpath('/prestashop/api/*')
      resources_list = []
      nodes.each{|n| resources_list << n.name.to_sym}
      return resources_list
    end
  end
end
