require "mobile_enhancements/version"
require "mobile_enhancements/configuration"
require "mobile_enhancements/request_helper"
require "mobile_enhancements/helper_delegation"

module MobileEnhancements
  # sets up the default configuration and returns the configuration singleton
  def self.configuration
    @configuration ||= Configuration.new do
      mobile do
        prefix "mobile"
        layout "mobile"
      end
      
      desktop do
        layout "application"
      end
    end
  end
  
  # used to configure the settings by users
  def self.configure(&block)
    configuration.instance_eval(&block)
  end
  
  # shortcut to the configuration mobile prefix
  def self.mobile_prefix
    configuration.mobile.prefix.gsub(/^\/|\/$/, "")
  end
end
