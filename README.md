This gem provides a few features to a Rails app which aid the production of a mobile-targeted UI.

Firstly, it provides the `mobile_only` and `mobile_optional` blocks to your routes, these let you define particular routes which can only be accessed via your mobile prefix (default: `/mobile`) or ones which will work for both desktop and mobile. For details on customising the prefix, and exact usage of the routes helpers, see the "Usage" section below.

[![Build Status][2]][1] [![Code Climate][3]][4]

  [1]: http://travis-ci.org/ryantownsend/mobile-enhancements
  [2]: https://secure.travis-ci.org/ryantownsend/mobile-enhancements.png?branch=master
  [3]: https://codeclimate.com/badge.png
  [4]: https://codeclimate.com/github/ryantownsend/mobile-enhancements

## Installation

Add this line to your application's Gemfile:

```ruby
gem "mobile-enhancements"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mobile-enhancements

## Usage

In your config/routes.rb file:

```ruby
YourApp::Application.routes.draw do
  # accessible via /items and /mobile/items
  mobile_optional do
    resource :items
  end
  
  # only accessible via /mobile/barcode_scanner
  mobile_only do
    get :barcode_scanner, to: "scans#new"
  end
  
  # only accessible via /guides (normal routing)
  resource :guides
end
```

By default the path prefix for mobile routes will be `mobile/`. The app will also use `layouts/application.mobile.erb` as the root mobile UI template unless specified otherwise.

You can customise these options by creating an initializer, here's an example `config/initializers/mobile_enhancements.rb` file (the defaults):

```ruby
require "mobile_enhancements"

MobileEnhancements.configure do
  mobile do
    # defines the path prefix used
    prefix "mobile"
    # defines the global view file
    layout "mobile"
    # defines the 'format' in view.format.renderer view filenames,
    # to use the same HTML as standard actions, simply set to "html"
    format "mobile"
  end
  
  desktop do
    layout "application"
  end
end
```

Notes

1) in your application controller, a `determine_layout` method will be defined which will choose which layout file it needs, if you want to override this in your own controllers, you can always use `super` to reference the original.

2) if you use a `format` like "mobile", instead of "html", then you'll need to update your controller's `respond_to :html, :json` method to include `mobile` in the list (or whatever you choose for your format)

A few helper methods are also provided (accessible both by your views and controllers):

```ruby
mobile_request?
mobile_path(path_to_convert)
mobile_url(url_to_convert)
desktop_request?
desktop_path(path_to_convert)
desktop_url(url_to_convert)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
