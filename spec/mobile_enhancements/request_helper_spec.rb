require "mobile_enhancements/configuration"
require "mobile_enhancements/request_helper"

describe MobileEnhancements::RequestHelper do
  let(:path) { "/" }
  let(:url) do
    "http://example.com#{path}"
  end
  
  let(:request) do
    mock(:request, url: url, path: path)
  end
  
  let(:configuration) do
    MobileEnhancements::Configuration.default
  end
  
  subject do
    MobileEnhancements::RequestHelper.new(request, configuration)
  end
  
  describe "::delegated_methods" do
    %w(
      mobile_url mobile_path mobile_request?
      desktop_url desktop_path desktop_request?
      determine_layout
    ).each do |method|
      it "should include #{method}" do
        expect(subject.class.delegated_methods.map(&:to_s)).to include method
      end
    end
  end
  
  context "when the URL contains a mobile path prefix" do
    let(:path) { "/mobile/items/mobile/iphone" }
    
    describe "#determine_layout" do
      it "should return the mobile layout defined in the config" do
        expect(subject.determine_layout).to eq configuration.mobile_layout
      end
    end
    
    describe "#mobile_url" do
      it "should return the URL untouched" do
        expect(subject.mobile_url).to eq url
      end
    end
    
    describe "#mobile_path" do
      it "should return the path untouched" do
        expect(subject.mobile_path).to eq path
      end
    end
    
    describe "#desktop_url" do
      it "should strip the mobile prefix from the URL" do
        expect(subject.desktop_url).to eq "http://example.com/items/mobile/iphone"
      end
    end
    
    describe "#mobile_path" do
      it "should strip the mobile prefix from the path" do
        expect(subject.desktop_path).to eq "/items/mobile/iphone"
      end
    end
    
    describe "#mobile_request?" do
      it "should return true" do
        expect(subject.mobile_request?).to be_true
      end
    end
    
    describe "#desktop_request?" do
      it "should return false" do
        expect(subject.desktop_request?).to be_false
      end
    end
  end

  context "when the URL does not contain a mobile path prefix" do
    let(:path) { "/items/mobile/iphone" }
    
    describe "#determine_layout" do
      it "should return the desktop layout defined in the config" do
        expect(subject.determine_layout).to eq configuration.desktop_layout
      end
    end
    
    describe "#mobile_url" do
      it "should prepend the path with a mobile prefix" do
        expect(subject.mobile_url).to eq "http://example.com/mobile#{path}"
      end
    end
    
    describe "#mobile_path" do
      it "should prepend the path with a mobile prefix" do
        expect(subject.mobile_path).to eq "/mobile#{path}"
      end
    end
    
    describe "#desktop_url" do
      it "should return the URL untouched" do
        expect(subject.desktop_url).to eq url
      end
    end
    
    describe "#mobile_path" do
      it "should return the path untouched" do
        expect(subject.desktop_path).to eq path
      end
    end
    
    describe "#mobile_request?" do
      it "should return false" do
        expect(subject.mobile_request?).to be_false
      end
    end
    
    describe "#desktop_request?" do
      it "should return true" do
        expect(subject.desktop_request?).to be_true
      end
    end
  end
end