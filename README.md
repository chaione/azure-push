# Azure::Push

This is a very simple Azure notification-hub implementation for sending push notifications to Mobile Devices.

## Installation

Add this line to your application's Gemfile:

    gem 'azure-push'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install azure-push

## Usage

    ap = Azure::Push::Message.new(namespace, hub, access_key)
    ap.send({aps: {alert: message, sound: true}, 'my_tag')

## Contributing

1. Fork it ( https://github.com/christian-s/azure-push/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
