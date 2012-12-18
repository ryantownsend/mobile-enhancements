require "mobile_enhancements/helper_delegation"

describe MobileEnhancements::HelperDelegation do
  let(:request) { mock(:request) }
  
  subject do
    Class.new do
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
  end
end