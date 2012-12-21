require "spec_helper"

describe TestController do
  render_views

  context "via the mobile UI" do
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/two" do
      before { get :two, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should render 'two, #{MobileEnhancements.configuration.mobile_format}'" do
        expect(response.body).to eq "two, #{MobileEnhancements.configuration.mobile_format}"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/path_rendering" do
      before { get :path_rendering, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should render a mobile path" do
        expect(response.body).to eq "/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
      
      it "should render the path_rendering template" do
        expect(response).to render_template "path_rendering"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/path_checking" do
      before { get :path_checking, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should render a mobile URL" do
        expect(response.body).to eq "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/redirect_checking" do
      before { get :redirect_checking, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should redirect to a mobile URL" do
        expect(response).to redirect_to "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/fixed_redirect_checking" do
      before { get :fixed_redirect_checking, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should redirect to a mobile URL" do
        expect(response).to redirect_to "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
    end
    
    describe "GET /#{MobileEnhancements.configuration.mobile_path_prefix}/mobile_to_desktop_path" do
      before { get :mobile_to_desktop_path, mobile: MobileEnhancements.configuration.mobile_path_prefix }
      
      it "should render a desktop URL" do
        expect(response.body).to eq "/one"
      end
    end
  end
  
  context "via the desktop UI" do
    describe "GET /two" do
      before { get :two }
      
      it "should render 'two, html'" do
        expect(response.body).to eq "two, html"
      end
    end
    
    describe "GET /path_rendering" do
      before { get :path_rendering }
      
      it "should render a desktop path" do
        expect(response.body).to eq "/two"
      end
      
      it "should render the path_rendering template" do
        expect(response).to render_template "path_rendering"
      end
    end
    
    describe "GET /path_checking" do
      before { get :path_checking }
      
      it "should render a desktop URL" do
        expect(response.body).to eq "http://test.host/two"
      end
    end
    
    describe "GET /redirect_checking" do
      before { get :redirect_checking }
      
      it "should redirect to a desktop URL" do
        expect(response).to redirect_to "http://test.host/two"
      end
    end
    
    describe "GET /fixed_redirect_checking" do
      before { get :fixed_redirect_checking }
      
      it "should redirect to a mobile URL" do
        expect(response).to redirect_to "http://test.host/#{MobileEnhancements.configuration.mobile_path_prefix}/two"
      end
    end
  end
end
