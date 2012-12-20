require "spec_helper"

describe TestController do
  context "via the mobile UI" do
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/two" do
      before { get :two, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should render 'two, #{MobileEnhancements.configuration.mobile_format}'" do
        expect(@response.body).to eq "two, #{MobileEnhancements.configuration.mobile_format}"
      end
    end
  end
  
  context "via the desktop UI" do
    describe "GET /two" do
      before { get :two }
      
      it "should render 'two, html'" do
        expect(@response.body).to eq "two, html"
      end
    end
  end
end
