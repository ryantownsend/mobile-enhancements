module MobileEnhancements
  module UrlHelper
    def url_for(*args)
      url = super
      # ignore our direct calls for desktop/mobile URLs
      if args.size == 1 && args.first.frozen?
        url
      # if it's from a mobile
      elsif mobile_request?
        # mobilify the url
        murl = mobile_url(url)
        # verify or resort to original
        verify_path(murl) || url
      # if it's a desktop request
      else
        # desktopify the url
        durl = desktop_url(super)
        # verify or resort to original
        verify_path(durl) || durl
      end
    end
    
    # ensures a URL/path exists
    def verify_path(url)
      path = strip_domain(url)
      Rails.application.routes.recognize_path(path) && url rescue false
    end
    
    # converts a URL/path to a path
    def strip_domain(url)
      url.gsub(/([a-z]+\:)?\/\/.*?\//i, "/")
    end
  end
end