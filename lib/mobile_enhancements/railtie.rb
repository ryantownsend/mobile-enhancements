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
      end
    end

  end
end