module MobileEnhancements
  class Configuration
    def mobile(&block)
      @options ||= {}
      @options[__method__] ||= Options.new
      if block_given?
        @options[__method__].instance_eval(&block)
      end
      @options[__method__]
    end
    alias_method :desktop, :mobile
    
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