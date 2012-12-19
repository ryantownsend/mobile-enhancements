require "forwardable"

module MobileEnhancements
  class RequestHelper
    extend Forwardable
    
    def self.delegated_methods
      instance_methods.select do |name|
        name =~ /^(desktop|mobile)\_/
      end << :determine_layout
    end
    
    def_delegators :configuration, :mobile_path_prefix, :mobile_layout, :desktop_layout

    attr_reader :request, :configuration

    def initialize(request, configuration)
      @request = request
      @configuration = configuration
    end
    
    # returns a string defining which layout file to use
    def determine_layout
      mobile_request? ? mobile_layout : desktop_layout
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