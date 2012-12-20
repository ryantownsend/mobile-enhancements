require "mobile_enhancements/route_helpers"
require "mobile_enhancements/helper_delegation"
require "rails/railtie"

module MobileEnhancements
  class Railtie < Rails::Railtie

    config.to_prepare do
      # setup our route helpers
      ActionDispatch::Routing::Mapper.send(:include, MobileEnhancements::RouteHelpers)
      # setup the path helpers
      ActionController::Base.send(:include, MobileEnhancements::HelperDelegation)
      # setup the layout calculation
      ActionController::Base.layout :determine_layout
      # if we have a custom mobile format
      if format = MobileEnhancements.configuration.mobile_format
        # register it as an alias to the HTML mime-type
        Mime::Type.register_alias "text/html", format
        # setup the format calculation
        ActionController::Base.class_eval do
          before_filter do |controller|
            if controller.mobile_request?
              controller.request.format = controller.determine_format
              controller.params["mobile"] = MobileEnhancements.configuration.mobile_path_prefix
            end
          end
        end
      end
    end

  end
end