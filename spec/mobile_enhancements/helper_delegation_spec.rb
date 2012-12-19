require "spec_helper"

describe MobileEnhancements::HelperDelegation do
  let(:request) { mock(:request) }
  
  subject do
    Class.new do
      def self.helper_method(*helpers)
        @helpers ||= []
        @helpers += helpers.flatten
      end
      
      def self.helper_methods
        @helpers || []
      end
      
      include MobileEnhancements::HelperDelegation
    end.new.tap do |inst|
      inst.stub(:request).and_return(request)
    end
  end
  
  MobileEnhancements::RequestHelper.delegated_methods.each do |method|
    it "should delegate ##{method} to RequestHelper" do
      subject.send(:mobile_enhancement_helpers).should_receive(method).and_return(true)
      subject.send(method)
    end
    
    it "should define ##{method} as a helper method" do
      expect(subject.class.helper_methods).to include method
    end
  end
end