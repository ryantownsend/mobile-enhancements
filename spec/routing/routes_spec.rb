require "spec_helper"

describe "standard routing" do
  it "routes /guides to guides#index" do
    expect(get: "/one").to route_to("test#one")
  end
end

describe "mobile-optional routing" do
  it "routes /items to items#index" do
    expect(get: "/two").to route_to({
      controller: "test",
      action: "two",
      mobile: nil
    })
  end
  
  it "routes /mobile/items to mobile#index" do
    expect(get: "/#{MobileEnhancements.configuration.mobile_path_prefix}/two").to route_to({
      controller: "test",
      action: "two",
      mobile: MobileEnhancements.configuration.mobile_path_prefix
    })
  end
end

describe "mobile-only routing" do
  it "does not route /pages to pages#index" do
    expect(get: "/three").not_to be_routable
  end

  it "routes /mobile/pages to pages#index" do
    expect(get: "/#{MobileEnhancements.configuration.mobile_path_prefix}/three").to route_to({
      controller: "test",
      action: "three",
      mobile: MobileEnhancements.configuration.mobile_path_prefix
    })
  end
end