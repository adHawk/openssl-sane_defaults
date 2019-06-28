# frozen_string_literal: true

require 'openssl'
require 'openssl/sane_defaults/version'

module OpenSSL
  # SaneDefaults
  module SaneDefaults
    class Error < StandardError; end

    # Make OpenSSL default params safer by disabling insecure options
    def self.patch!
      # Disable insecure protocols, Postgres on RDS no longer accepts TLSv1
      # Shamelessly taken, and slightly modified from https://gist.github.com/tam7t/86eb4793e8ecf3f55037#gistcomment-1361208
      SSL::SSLContext::DEFAULT_PARAMS[:options] |= SSL::OP_NO_SSLv2
      SSL::SSLContext::DEFAULT_PARAMS[:options] |= SSL::OP_NO_SSLv3
      SSL::SSLContext::DEFAULT_PARAMS[:options] |= SSL::OP_NO_TLSv1
      SSL::SSLContext::DEFAULT_PARAMS[:options] |= SSL::OP_NO_COMPRESSION

      true
    end
  end
end
