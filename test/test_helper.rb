$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'prestashopper'

require 'minitest/autorun'
require 'webmock/minitest'

# No real network connections allowed during testing
WebMock.disable_net_connect!
