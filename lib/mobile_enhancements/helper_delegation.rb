require "forwardable"
require "mobile_enhancements"
require "mobile_enhancements/request_helper"

module MobileEnhancements
  module HelperDelegation
    def self.included(base)
      base.extend Forwardable
      base.class_eval do
        def_delegators :mobile_enhancement_helpers, *RequestHelper.delegated_methods
      end
    end

    private
    def mobile_enhancement_helpers
      @mobile_enhancement_helpers ||= begin
        path_prefix = MobileEnhancements.mobile_prefix
        RequestHelper.new(request, path_prefix)
      end
    end
  end
end