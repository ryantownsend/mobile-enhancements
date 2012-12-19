require "spec_helper"

describe "standard routing" do
  it "routes /guides to guides#index" do
    expect(get: "/guides").to route_to(
      controller: "guides",
      action: "index"
    )
  end

  it "routes /guides/1 to guides#show" do
    expect(get: "/guides/1").to route_to(
      controller: "guides",
      action: "show",
      id: 1
    )
  end
end

describe "mobile-optional routing" do
  it "routes /items to items#index" do
    expect(get: "/items").to route_to(
      controller: "items",
      action: "index"
    )
  end
  
  it "routes /mobile/items to mobile#index" do
    expect(get: "/mobile/items").to route_to(
      controller: "items",
      action: "index",
      mobile: "mobile"
    )
  end
end

describe "mobile-only routing" do
  it "does not route /pages to pages#index" do
    expect(get: "/page").not_to be_routable
  end

  it "routes /mobile/pages to pages#index" do
    expect(get: "/mobile/pages").to route_to(
      controller: "pages",
      action: "index",
      mobile: "mobile"
    )
  end
end