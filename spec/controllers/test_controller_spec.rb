require "spec_helper"

describe TestController do
  context "via the mobile UI" do
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/two" do
      before { get :two, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should render 'two, #{MobileEnhancements.configuration.mobile_format}'" do
        expect(@response.body).to eq "two, #{MobileEnhancements.configuration.mobile_format}"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/path_checking" do
      before { get :path_checking, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should render a mobile URL" do
        expect(@response.body).to eq "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/redirect_checking" do
      before { get :redirect_checking, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should redirect to a mobile URL" do
        expect(@response.headers["Location"]).to eq "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/fixed_redirect_checking" do
      before { get :fixed_redirect_checking, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should redirect to a mobile URL" do
        expect(@response.headers["Location"]).to eq "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
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
    
    describe "GET /path_checking" do
      before { get :path_checking }
      
      it "should render a desktop URL" do
        expect(@response.body).to eq "http://test.host/two"
      end
    end
    
    describe "GET /redirect_checking" do
      before { get :redirect_checking }
      
      it "should redirect to a desktop URL" do
        expect(@response.headers["Location"]).to eq "http://test.host/two"
      end
    end
    
    describe "GET /fixed_redirect_checking" do
      before { get :fixed_redirect_checking }
      
      it "should redirect to a mobile URL" do
        expect(@response.headers["Location"]).to eq "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
    end
  end
end
