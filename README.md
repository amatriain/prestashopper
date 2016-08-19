[![Gem Version](https://badge.fury.io/rb/prestashopper.svg)](https://badge.fury.io/rb/prestashopper)
[![Build Status](https://semaphoreci.com/api/v1/amatriain/prestashopper/branches/master/badge.svg)](https://semaphoreci.com/amatriain/prestashopper)
[![Yard Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://www.rubydoc.info/github/amatriain/prestashopper/master)

# Prestashopper

Prestashopper is a ruby gem to interact with a Prestashop API. It has been tested with Prestashop v1.6.1.2

Prestashop is an open source e-commerce application written in PHP: [visit the homepage](https://www.prestashop.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prestashopper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prestashopper
    
## Enabling the Prestashop API and creating an API key

For security reasons the Prestashop API is disabled by default. To be able to use this gem you will have to enable it.

Once enabled you'll have to create an API key and give it the necessary permissions for the operations you intend to perform. Most methods in this gem need a valid API key.

For more information about enabling the Prestashop API and managing API keys and their permissions, see the [official documentation](http://doc.prestashop.com/display/PS16/Using+the+PrestaShop+Web+Service).

## Usage

### Checking if the Prestashop API is enabled
```
Prestashopper.api_enabled? 'my.prestashop.com'
=> true
```

### Checking if an API key is valid
```
Prestashopper.valid_key? 'my.prestashop.com', 'VALID_KEY'
=> true
```

### Getting an API instance
```
api = Prestashopper::API.new 'my.prestashop.com', 'VALID_KEY'
```

### Listing resources that can be accessed from an API instance
```
api.resources
 => [:customers, :orders, :products] 
```

### Gettting products
```
products = api.get_products
products[0].description
=>  "product 1"
products[0].price
=> "24.71"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. The documentation can be generated from the yard comments running `yard doc`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/amatriain/prestashopper](https://github.com/amatriain/prestashopper).


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

