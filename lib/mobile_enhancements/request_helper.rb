module MobileEnhancements
  class RequestHelper
    attr_reader :request
    
    def initialize(request)
      @request = request
    end
    
    # strips any mobile prefix from the url
    def desktop_url(url = request.url)
      desktop_path(url)
    end

    # strips any mobile prefix from the path
    def desktop_path(path = request.path)
      path.gsub(/^(.*?\/\/.*?)?\/(mobile\/?)?(.*)$/, '\1/\3').freeze
    end
    
    # ensures a mobile prefix exists in the url
    def mobile_url(url = request.url)
      mobile_path(url)
    end

    # ensures a mobile prefix exists in the path
    def mobile_path(path = request.path)
      path.gsub(/^(.*?\/\/.*?)?\/(mobile\/?)?(.*)$/, '\1/mobile/\3').freeze
    end
    
    # returns whether or not this is a mobile request
    def mobile_request?
      @mobile_request ||= !!(request.path =~ /^\/mobile(\/.*)?$/)
    end
    
    # returns whether or not this is a desktop request
    def desktop_request?
      !mobile_request?
    end
  end
end