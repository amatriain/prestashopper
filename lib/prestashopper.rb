require 'prestashopper/version'
require 'rest-client'
require 'prestashopper/api'
require 'prestashopper/uri_handler'

# @author Alfredo Amatriain <geralt@gmail.com>
#
# Ruby gem for interacting with the Prestashop API.
module Prestashopper

  # Check if an API key is valid.
  # @param url [String] base URL of the Prestashop installation. Do not append "/api" to it, the gem does it internally.
  #   E.g. use "http://my.prestashop.com", not "http://my.prestashop.com/api"
  # @param key [String] the key to check
  # @return [boolean] true if key is valid, false otherwise
  def self.valid_key?(url, key)
    return false
  end

  # Check if there is an enabled API in a Prestashop instance.
  # @param url [String] base URL of the Prestashop installation. Do not append "/api" to it, the gem does it internally.
  # @return [boolean] true if the API is enabled, false if it is disabled, nil if an unexpected response is received.
  def self.api_enabled?(url)
    api_uri = UriHandler.api_uri url
    res = RestClient::Resource.new api_uri, user: '', password: ''
    begin
      response = res.get
      # TODO raise error
      return nil # We don't send an API key, so an HTTP error code should be returned. Execution shouldn't reach here normally.
    rescue RestClient::Exception => e
      if e.response.code == 401
        return true # "Unauthorized" response means API is enabled
      elsif e.response.code == 503
        return false # "Service Unavailable" response means API is disabled
      else
        # TODO raise error
        return nil # Any other HTTP error code means something is wrong
      end
    end
  end
end
