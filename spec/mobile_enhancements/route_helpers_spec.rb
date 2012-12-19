require "spec_helper"

describe MobileEnhancements::RouteHelpers do
  subject do
    Class.new do
      include MobileEnhancements::RouteHelpers
      
      def scopes
        @scopes
      end
      
      def scope(*args)
        @scopes ||= []
        @scopes << args
      end
    end.new
  end
  
  context "given a mobile_optional block" do
    before do
      subject.mobile_optional do
        resources :items
      end
    end

    it "should define a scope" do
      expect(subject.scopes.size).to eq 1
    end
  end
  
  context "given a mobile_only block" do
    before do
      subject.mobile_only do
        resources :items
      end
    end
  
    it "should define a scope" do
      expect(subject.scopes.size).to eq 1
    end
  end

end