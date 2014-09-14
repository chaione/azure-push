require 'cgi'
require 'base64'
require 'digest'

module Azure
  module Push
    module Sas
      def self.sas_token(url, key_name, access_key, lifetime: 10)
        target_uri = CGI.escape(url.downcase).gsub('+', '%20').downcase
        expires = Time.now.to_i + lifetime
        to_sign = "#{target_uri}\n#{expires}"
        signature = CGI.escape(Base64.strict_encode64(Digest::HMAC.digest(to_sign, access_key, Digest::SHA256))).gsub('+', '%20')
        token = "SharedAccessSignature sr=#{target_uri}&sig=#{signature}&se=#{expires}&skn=#{key_name}"
      end
    end
  end
end