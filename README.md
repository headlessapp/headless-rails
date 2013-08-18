# Headless::Rails

[![Build Status](https://travis-ci.org/headlessapp/headless-rails.png?branch=master)](https://travis-ci.org/headlessapp/headless-rails)

API wrapper for the headlessapp.com service.

Seamlessly integrate AJAX webcrawler support into your javascript application.

Sign up at http://www.headlessapp.com and install the gem.

## Installation

Add this line to your application's Gemfile:

    gem 'headless-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install headless-rails

## Usage

Open your production.rb,
and add the following;

    require 'headless/rails'
    config.middleware.use Headless::Rails::Middleware

That's it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
