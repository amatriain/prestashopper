require 'prestashopper/version'
require 'prestashopper/api'

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
end
