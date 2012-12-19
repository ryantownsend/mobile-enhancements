require "forwardable"
require "mobile_enhancements"
require "mobile_enhancements/request_helper"

module MobileEnhancements
  module HelperDelegation
    def self.included(base)
      base.extend Forwardable
      base.def_delegators :mobile_enhancement_helpers, *RequestHelper.delegated_methods
      # make the methods available as helpers if available
      if base.respond_to?(:helper_method)
        base.helper_method *RequestHelper.delegated_methods
      end
    end

    private
    def mobile_enhancement_helpers
      @mobile_enhancement_helpers ||= RequestHelper.new(request, MobileEnhancements.configuration)
    end
  end
end