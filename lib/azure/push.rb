require "azure/push/version"

module Azure
  class Push

    def initialize(namespace, hub, access_key, 
        key_name: 'DefaultFullSharedAccessSignature',
        sig_lifetime: 60)
      @access_key = access_key
      @key_name = key_name
      @namespace = namespace
      @hub = hub
    end

    def send(payload, tags: '', format: 'apple')
      raise ArgumentError unless ['apple', 'gcm', 'template'].include? format
      if tags.instance_of?(Array)
        tags = tags.join(' || ')
      end
      uri = URI(url)
      headers = {
        'Content-Type' => 'application/json',
        'Authorization' => sas_token,
        'ServiceBusNotification-Format' => format,
        'ServiceBusNotification-Tags' => tags
      }
      http = Net::HTTP.new(uri.host,uri.port)
      http.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, initheader = headers)
      req.body = payload.to_json
      http.request(req)
    end

    private

    def url
      "https://#{@namespace}.servicebus.windows.net/#{@hub}/messages"
    end

    def sas_token
      target_uri = CGI.escape(url.downcase).gsub('+', '%20').downcase
      expires = (DateTime.current + 60.minutes).to_i
      to_sign = "#{target_uri}\n#{expires}"
      signature = CGI.escape(Base64.strict_encode64(Digest::HMAC.digest(to_sign, @key, Digest::SHA256))).gsub('+', '%20')
      token = "SharedAccessSignature sr=#{target_uri}&sig=#{signature}&se=#{expires}&skn=#{@key_name}"
    end

  end
end
