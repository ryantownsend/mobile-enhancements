require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end

require "combustion"
Combustion.initialize!(:action_controller)

require "mobile_enhancements"
require "rspec/rails"

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each { |f| require f }