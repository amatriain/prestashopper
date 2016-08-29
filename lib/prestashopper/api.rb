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
      @resources ||= Nokogiri::XML(@resources_res.get.body).xpath('/prestashop/api/*').collect { |resource| resource.name.to_sym }
    end

    def method_missing(method, *args, &block)
      if method.to_s.starts_with?('get_')
        resource = method.to_s.sub(/^get_/,'').pluralize.to_sym
        raise 'You do not have access to this resource' unless resources.include?(resource)
        if args.any?
          ids = args.first.is_a?(Array) ? args.first : args
          objects = ids.collect do |resource_id|
            Hash.from_xml(Nokogiri::XML(@resources_res[resource][resource_id].get.body).remove_namespaces!.xpath("/prestashop/#{resource.to_s.singularize}").to_s).values
          end.flatten.collect { |resource_hash| JSON.parse(resource_hash.to_json, object_class: OpenStruct) }
        else
          objects = Nokogiri::XML(@resources_res[resource].get.body).xpath("/prestashop/#{resource}/*/@id").collect(&:value)
        end
      else
        super
      end
    end
  end
end
