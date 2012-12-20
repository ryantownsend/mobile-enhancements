module MobileEnhancements
  module UrlHelper
    def url_for(*args)
      # ignore our direct calls for desktop/mobile URLs
      if args.size == 1 && args.first.frozen?
        super
      # if it's from a mobile
      elsif mobile_request?
        # mobilify the url
        mobile_url(super)
      # if it's a desktop request
      else
        # process as normal
        super
      end
    end
  end
end