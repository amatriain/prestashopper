module Prestashopper

  # Handle URIs, converting from base Prestashop URL to API URIs
  class UriHandler
    API_PATH = 'api/'

    # Convert a base Prestashop URL to its API URI
    # @param base_url [String] a Prestashop base URL. Do not append "/api", it is appended internally. E.g. use
    #   "http://my.prestashop.com/", not "http://my.prestashop.com/api"
    # @return [URI] the URI of the API for this Prestashop instance
    def self.api_uri(base_url)
      # Base URL must end in '/' so that we can properly append other path fragments for the API paths
      base_url.strip!
      base_url += '/' unless base_url[-1] == '/'

      uri = URI.join base_url, API_PATH
      return uri
    end
  end
end