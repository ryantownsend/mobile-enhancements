require "forwardable"

module MobileEnhancements
  class RequestHelper
    extend Forwardable
    
    def self.delegated_methods
      instance_methods.select do |name|
        name =~ /^(desktop|mobile)\_/
      end + [:determine_layout, :determine_format]
    end
    
    def_delegators :configuration, :mobile_path_prefix, :mobile_layout, :desktop_layout, :mobile_format

    attr_reader :request, :configuration

    def initialize(request, configuration)
      @request = request
      @configuration = configuration
    end
    
    # returns a string defining which layout file to use
    def determine_layout
      mobile_request? ? mobile_layout : desktop_layout
    end
    
    # returns what format should be used by the request
    def determine_format
      mobile_request? ? mobile_format.to_sym : request.format.to_sym
    end
    
    # returns what the value of the mobile parameter should be
    def mobile_param_value
      mobile_request? ? mobile_path_prefix : nil
    end
    
    # strips any mobile prefix from the url
    def desktop_url(url = request.url)
      desktop_path(url)
    end

    # strips any mobile prefix from the path
    def desktop_path(path = request.path)
      path.gsub(/^(.*?\/\/.*?)?\/(#{mobile_path_prefix}\/?)?(.*)$/) do
        "#{$1}/#{$3}"
      end.freeze
    end
    
    # ensures a mobile prefix exists in the url
    def mobile_url(url = request.url)
      mobile_path(url)
    end

    # ensures a mobile prefix exists in the path
    def mobile_path(path = request.path)
      path.gsub(/^(.*?\/\/.*?)?\/(#{mobile_path_prefix}\/?)?(.*)$/) do
        "#{$1}/#{mobile_path_prefix}/#{$3}"
      end.freeze
    end
    
    # returns whether or not this is a mobile request
    def mobile_request?
      @mobile_request ||= !!(request.path =~ /^\/#{mobile_path_prefix}(\/.*)?$/)
    end
    
    # returns whether or not this is a desktop request
    def desktop_request?
      !mobile_request?
    end
  end
end