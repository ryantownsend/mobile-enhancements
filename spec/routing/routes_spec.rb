require "spec_helper"

describe "standard routing" do
  it "routes /one to test#one" do
    expect(get: "/one").to route_to("test#one")
  end
end

describe "mobile-optional routing" do
  it "routes /two to test#two" do
    expect(get: "/two").to route_to({
      controller: "test",
      action: "two",
      mobile: nil
    })
  end
  
  it "routes /#{MobileEnhancements.configuration.mobile_path_prefix}/two to test#two" do
    expect(get: "/#{MobileEnhancements.configuration.mobile_path_prefix}/two").to route_to({
      controller: "test",
      action: "two",
      mobile: MobileEnhancements.configuration.mobile_path_prefix
    })
  end
end

describe "mobile-only routing" do
  it "does not route /three" do
    expect(get: "/three").not_to be_routable
  end

  it "routes /#{MobileEnhancements.configuration.mobile_path_prefix}/three to test#three" do
    expect(get: "/#{MobileEnhancements.configuration.mobile_path_prefix}/three").to route_to({
      controller: "test",
      action: "three",
      mobile: MobileEnhancements.configuration.mobile_path_prefix
    })
  end
  
  it "routes /#{MobileEnhancements.configuration.mobile_path_prefix} to test#four" do
    expect(get: "/#{MobileEnhancements.configuration.mobile_path_prefix}").to route_to({
      controller: "test",
      action: "four",
      mobile: MobileEnhancements.configuration.mobile_path_prefix
    })
  end
end