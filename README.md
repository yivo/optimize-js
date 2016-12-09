## Ruby wrapper and Rails asset pipeline integration for [optimize-js](https://github.com/nolanlawson/optimize-js).

## About
This gem is ruby wrapper for [optimize-js](https://github.com/nolanlawson/optimize-js). It allows you to invoke optimize-js from ruby. For Rails users this gem automatically integrates optimize-js into sprockets.

## Installing gem

**If you are using bundler.**
<br>
Add to your Gemfile:
```ruby
gem 'optimize-js', '~> 1.0'
```

**If you are not using bundler.**
<br>
Run in your terminal:
```
gem install optimize-js
```
Require gem in your ruby sources:
```ruby
require 'optimize-js'
```

## Using gem
API is quite simple.
```ruby
# OptimizeJS.perform(javascript_source, optimize_js_options)

OptimizeJS.perform('!function() {}()') # => !(function() {})()
```

## Using in Rails
There is no need to do anything.
<br>
Gem will automatically register `OptimizeJS::SprocketsProcessor` using `register_bundle_processor` so all your JavaScript assets will be optimized.

## Running tests
1. Install gem dependencies: `bundle install`
2. Run tests: `bundle exec rake test`

## Things to work on
1. Write integration tests.
2. Test on different versions of sprockets.
3. Test on different versions of rails.
4. Test on different versions of ruby.
5. Sprockets without Rails.
6. Typos in README.
