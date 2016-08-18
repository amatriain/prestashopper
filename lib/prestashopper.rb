require 'prestashopper/version'
require 'rest-client'
require 'nokogiri'
require 'prestashopper/api'
require 'prestashopper/product'
require 'prestashopper/uri_handler'

# @author Alfredo Amatriain <geralt@gmail.com>
#
# Ruby gem for interacting with the Prestashop API.
module Prestashopper

  # Check if there is an enabled API in a Prestashop instance.
  # @param url [String] base URL of the Prestashop installation. Do not append "/api" to it, the gem does it internally.
  #   E.g. use "http://my.prestashop.com", not "http://my.prestashop.com/api"
  # @return [boolean] true if the API is enabled, false if it is disabled
  # @raise [RestClient::Exception] if there is an error during HTTP GET
  # @raise [StandardError] if a response different from 401 or 503 is received (not counting redirect responses,
  #   which will be followed)
  def self.api_enabled?(url)
    api_uri = UriHandler.api_uri url
    res = RestClient::Resource.new api_uri, user: '', password: ''
    begin
      response = res.get
      # We don't send an API key, so an HTTP error code should be returned. Execution shouldn't reach here normally.
      raise StandardError.new "Expected 401 or 503 response from Prestashop API #{api_uri} without key, instead received <#{response.code}> #{response.body}"
    rescue RestClient::Exception => e
      if e.response.code == 401
        return true # "Unauthorized" response means API is enabled
      elsif e.response.code == 503
        return false # "Service Unavailable" response means API is disabled
      else
        raise e # Any other HTTP error code means something is wrong
      end
    end
  end

  # Check if an API key is valid.
  # @param url [String] base URL of the Prestashop installation. Do not append "/api" to it, the gem does it internally.
  #   E.g. use "http://my.prestashop.com", not "http://my.prestashop.com/api"
  # @param key [String] the key to check
  # @return [boolean] true if key is valid, false otherwise
  # @raise [RestClient::Exception] if there is an error during HTTP GET
  # @raise [StandardError] if a response different from 200 or 401 is received (not counting redirect responses,
  #   which will be followed)
  def self.valid_key?(url, key)
    api_uri = UriHandler.api_uri url
    res = RestClient::Resource.new api_uri, user: key, password: ''
    begin
      response = res.get
      if response.code == 200 # OK response means API key is valid
        return true
      else
        raise StandardError.new "Expected 200 or 401 response from Prestashop API #{api_uri} with key #{key}, instead received <#{response.code}> #{response.body}"
      end
    rescue RestClient::Exception => e
      if e.response.code == 401
        return false # "Unauthorized" response means API key is invalid
      else
        raise e # Any other HTTP error code means something is wrong
      end
    end
  end

end
