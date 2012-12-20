require "spec_helper"

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
        format "mbl"
      end
    end
    
    it "should store the prefix" do
      expect(subject.mobile.prefix).to eq "m"
      expect(subject.mobile_path_prefix).to eq "m"
    end
    
    it "should store the layout" do
      expect(subject.mobile.layout).to eq "mob"
      expect(subject.mobile_layout).to eq "mob"
    end
    
    it "should store the format" do
      expect(subject.mobile.format).to eq "mbl"
      expect(subject.mobile_format).to eq :mbl
    end
    
    it "should raise method missing for undefined options" do
      expect { subject.mobile.banana(1,2) }.to raise_error(NoMethodError)
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
      expect(subject.desktop_layout).to eq "desktop"
    end
  end
end