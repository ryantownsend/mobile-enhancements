require "mobile_enhancements/configuration"

describe MobileEnhancements::Configuration do
  subject do
    MobileEnhancements::Configuration.new
  end
  
  context "with no configuration settings defined" do
    it "should return nil for settings" do
      expect(subject.mobile.prefix).to be_nil
      expect(subject.mobile.layout).to be_nil
      expect(subject.desktop.layout).to be_nil
    end
  end
  
  describe "defining mobile configuration" do
    before do
      subject.mobile do
        prefix "m"
        layout "mob"
      end
    end
    
    it "should store the prefix" do
      expect(subject.mobile.prefix).to eq "m"
    end
    
    it "should store the layout" do
      expect(subject.mobile.layout).to eq "mob"
    end
  end
  
  describe "defining desktop configuration" do
    before do
      subject.desktop do
        layout "desktop"
      end
    end
    
    it "should store the layout" do
      expect(subject.desktop.layout).to eq "desktop"
    end
  end
end