require "mobile_enhancements"

module MobileEnhancements
  module RouteHelpers
    # all routes defined within the mobile_only block will require the mobile
    # prefix
    def mobile_only(&block)
      scope(mobile_path_prefix, mobile: mobile_path_prefix, &block)
    end
    
    # all routes defined within the mobile_optional block will be accessible
    # with and without the mobile prefix
    def mobile_optional(&block)
      scope("(:mobile)", {
        defaults: { mobile: nil },
        mobile: /(#{mobile_path_prefix})?/
      }, &block)
    end

    private
    def mobile_path_prefix
      MobileEnhancements.configuration.mobile_path_prefix
    end
  end
end