require "mobile_enhancements/version"
require "mobile_enhancements/configuration"
require "mobile_enhancements/request_helper"

module MobileEnhancements
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.configure(&block)
    configuration.yield(block)
  end
end
