module MobileEnhancements
  class Configuration
    def self.default
      new do
        mobile do
          prefix "mobile"
          layout "application"
          format "mobile"
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
    
    def mobile_format
      if mobile.format && mobile.format.to_sym != :html
        mobile.format.to_sym
      end
    end
    
    class Options
      # force format to pass through
      def format(*args)
        method_missing("format", *args)
      end

      def read_attribute(name)
        (@properties ||= {})[name]
      end
      
      def write_attribute(name, value)
        (@properties ||= {})[name] = value
      end
      
      def method_missing(name, *args, &block)
        case args.size
        when 0
          read_attribute(name)
        when 1
          write_attribute(name, args.first)
        else
          super
        end
      end
    end
  end
end