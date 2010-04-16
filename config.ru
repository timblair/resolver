$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require 'resolver'

run Resolver::Application
