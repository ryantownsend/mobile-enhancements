module MobileEnhancements
  class Configuration
    def self.default
      new do
        mobile do
          prefix "mobile"
          layout "application"
          mimetype "mobile"
        end
        
        desktop do
          layout "application"
        end
      end
    end
    
    def initialize(&block)
      instance_eval(&block) if block_given?
    end
    
    def mobile(&block)
      @options ||= {}
      @options[__method__] ||= Options.new
      if block_given?
        @options[__method__].instance_eval(&block)
      end
      @options[__method__]
    end
    alias_method :desktop, :mobile
    
    def mobile_path_prefix
      mobile.prefix.gsub(/^\/|\/$/, "")
    end
    
    def mobile_layout
      mobile.layout
    end
    
    def desktop_layout
      desktop.layout
    end
    
    class Options
      def method_missing(name, *args, &block)
        case args.size
        when 0
          (@properties ||= {})[name]
        when 1
          (@properties ||= {})[name] = args.first
        else
          super
        end
      end
    end
  end
end