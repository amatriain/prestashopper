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
      if method.to_s.match(/^get_/)
        resource = method.to_s.sub(/^get_/,'').pluralize.to_sym
        raise RestClient::MethodNotAllowed, 'You do not have access to this resource' unless resources.include?(resource)
        
        if method.to_s == method.to_s.singularize
          get_resource(resource, collect_ids_for_resource(args), true)
        else
          ids = collect_ids_for_resources(args)
          ids.present? ? get_resources(resource, ids) : get_resource_ids(resource)
        end
      else
        super
      end
    end

    private

    def get_resource_ids(resource)
      Nokogiri::XML(@resources_res[resource].get.body).xpath("/prestashop/#{resource}/*/@id").collect(&:value)
    end

    def get_resource(resource, id, raise_not_found_exception = false)
      resource_class_name = resource.to_s.classify
      resource_class = "Prestashopper::#{resource_class_name}".safe_constantize || Prestashopper.const_set(resource_class_name, Class.new(OpenStruct))

      begin
        response = Nokogiri::XML(@resources_res[resource][id].get.body).remove_namespaces!.xpath("/prestashop/#{resource.to_s.singularize}")
        JSON.parse(Hash.from_xml(response.to_s).values.first.to_json, object_class: resource_class)
      rescue RestClient::NotFound
        raise if raise_not_found_exception
        nil
      end
    end

    def get_resources(resource, ids)
      ids.uniq.sort.collect { |id| get_resource(resource, id) }.compact
    end

    def collect_ids_for_resource(args)
      raise ArgumentError, "wrong number of arguments (#{args.length} for 1)" unless args.one?
      id = args.first
      validate_resource_id_type(id)
      id
    end

    def collect_ids_for_resources(args)
      return nil if args.none?
      raise TypeError, 'Arguments must be a list of resource ids' unless args.is_a?(Array)
      args.each { |id| validate_resource_id_type(id) }
      args
    end

    def validate_resource_id_type(id)
      raise TypeError, 'Argument must be a valid resource id type' unless id.is_a?(Numeric) || id.is_a?(String)
      id
    end
  end
end
