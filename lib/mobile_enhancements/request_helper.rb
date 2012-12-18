module MobileEnhancements
  class RequestHelper
    attr_reader :request, :path_prefix
    
    def initialize(request, path_prefix = nil)
      @request = request
      @path_prefix = path_prefix || default_path_prefix
    end
    
    # strips any mobile prefix from the url
    def desktop_url(url = request.url)
      desktop_path(url)
    end

    # strips any mobile prefix from the path
    def desktop_path(path = request.path)
      path.gsub(/^(.*?\/\/.*?)?\/(#{path_prefix}\/?)?(.*)$/) do
        "#{$1}/#{$3}"
      end.freeze
    end
    
    # ensures a mobile prefix exists in the url
    def mobile_url(url = request.url)
      mobile_path(url)
    end

    # ensures a mobile prefix exists in the path
    def mobile_path(path = request.path)
      path.gsub(/^(.*?\/\/.*?)?\/(#{path_prefix}\/?)?(.*)$/) do
        "#{$1}/#{path_prefix}/#{$3}"
      end.freeze
    end
    
    # returns whether or not this is a mobile request
    def mobile_request?
      @mobile_request ||= !!(request.path =~ /^\/#{path_prefix}(\/.*)?$/)
    end
    
    # returns whether or not this is a desktop request
    def desktop_request?
      !mobile_request?
    end
    
    private
    def default_path_prefix
      (MobileEnhancements.configuration.mobile.prefix || "mobile").gsub(/^\/|\/$/, "")
    end
  end
end