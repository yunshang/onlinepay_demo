require "onlinepay_demo/version"
require 'onlinepay_demo/service'
require 'onlinepay_demo/base'
require 'faraday'

module OnlinepayDemo
  class << self
    cattr_accessor: :merchant_key, :env, :endpoint, :api_url

    ENDPOINT_DEV = 'https://business.sandbox.onlinepay.com'
    ENDPOINT_PRO = 'https://business.onlinepay.com'

    @@env = env['rack_env']; @@env ||= 'development'
    @@endpoint = ( @@env == "production" ? endpoint_pro : endpoint_dev )
   end
end
