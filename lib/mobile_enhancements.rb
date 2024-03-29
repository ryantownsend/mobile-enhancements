require "mobile_enhancements/version"
require "mobile_enhancements/configuration"
require "mobile_enhancements/request_helper"
require "mobile_enhancements/helper_delegation"
require "mobile_enhancements/route_helpers"

if defined?(Rails)
  require "mobile_enhancements/railtie"
end

module MobileEnhancements
  # sets up the default configuration and returns the configuration singleton
  def self.configuration
    @configuration ||= Configuration.default
  end
  
  # used to configure the settings by users
  def self.configure(&block)
    configuration.instance_eval(&block)
  end
end