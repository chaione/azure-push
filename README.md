# Azure::Push

This is a very simple Azure notification-hub implementation for sending push notifications to Mobile Devices.

## Installation

This gem is available on Rubygems: (https://rubygems.org/gems/azure-push)

Add this line to your application's Gemfile:

    gem 'azure-push'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install azure-push

## Usage

    ap = Azure::Push::Message.new(namespace, hub, access_key)
    ap.send({aps: {alert: message, sound: true}, 'my_tag')

The default Message format is 'apple'. Since v0.0.2 all available formats are supported.

Formats: 'apple', 'gcm', 'template', 'windows', 'windowsphone'

    ap.send(xml_string, 'my_tag', format: 'windows')

You can also add additional headers:

    ap.send(xml_string, 'my_tag', format: 'windows', additional_headers: {'X-Special-Windows-Header' => 'value'})

## Contributing

1. Fork it ( https://github.com/christian-s/azure-push/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Roadmap / Upcoming Features

- Read & Delete Registrations / Tags
- Create, Update Registrations
- Notification Hub management