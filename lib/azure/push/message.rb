require 'azure/push/sas'
require 'uri'
require 'net/https'
require 'json'

module Azure
  module Push
    class Message
      include Azure::Push::Sas

      def initialize(namespace, hub, access_key, 
          key_name: 'DefaultFullSharedAccessSignature',
          sig_lifetime: 10)
        @access_key = access_key
        @key_name = key_name
        @namespace = namespace
        @hub = hub
        @sig_lifetime = sig_lifetime
      end

      def send(payload, tags, format: 'apple')
        raise ArgumentError unless ['apple', 'gcm', 'template'].include? format
        if tags.instance_of?(Array)
          tags = tags.join(' || ')
        end
        uri = URI(url)
        headers = {
          'Content-Type' => 'application/json',
          'Authorization' => sas_token(url, @key_name, @access_key, lifetime: @sig_lifetime),
          'ServiceBusNotification-Format' => format,
          'ServiceBusNotification-Tags' => tags
        }
        http = Net::HTTP.new(uri.host,uri.port)
        http.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, initheader = headers)
        req.body = payload.to_json
        res = http.request(req)
        res.is_a?(Net::HTTPSuccess) ? true : res
      end

      private

      def url
        "https://#{@namespace}.servicebus.windows.net/#{@hub}/messages"
      end
    end
  end
end