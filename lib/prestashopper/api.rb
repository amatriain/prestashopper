module Prestashopper

  # Each instance represents a Prestashop API instance.
  class API

    # Check if an API key is valid.
    # @param key [String] the key to check
    # @return [boolean] true if key is valid, false otherwise
    def valid_key?(key)
      return false
    end
  end
end
