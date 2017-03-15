module OnlinepayDemo
  class Service < Base
    attr_accessor :args, :api_url
    Pay_Params_Check = %w(product amount currency)
    def self.payment(param)
      check_required_params(params, Pay_Params_Check)
      new.instance_eval do
        @api_url = '/api/v1/payments'
        self.args = param
        post_service
      end
    end

    def self.query_list(param)
      new.instance_eval do
        @api_url = '/api/v1/payments'
        self.args = param
        get_service
      end
    end

    def self.query_single(param)
      new.instance_eval do
        @api_url = "/api/v1/payments/#{params}"
        get_service
      end
    end

    def self.payment_confirmation(params)
      new.instance_eval do
        @api_url = "/api/v1/payments/p/#{params}"
        get_service
      end
    end

    Payout_Params_Check = %w(walletToken amount currency orderNumber bankAccount billing)
    def self.payout(param)
      check_required_params(params, Payout_Params_Check)
      new.instance_eval do
        @api_url = '/api/v1/payouts'
        self.args = param
        post_service
      end
    end

    Balance_Params_Check = %w(currency)
    def balance(params)
      check_required_params(params, Balance_Params_Check)
      new.instance_eval do
        @api_url = '/api/v1/balance'
        self.args = param
        get_service
      end
    end

    def self.check_required_params(params, names)
      if empty?(OnlinepayDemo['merchant_key'])
        raise('merchant_private_key can\'t be empty')
      end
      names.each do |name|
        raise("Onlinepay Warn: missing required option: #{name}") unless params.has_key?(name)
      end
    end

    private
    def post_service
      connection = faraday.new
      begin
        connection.post do |req|
          req.url @api_url
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "Bearer #{OnlinepayDemo.merchant_key}"
          req.body = self.args
        end
      rescue StandardError => ex
         raise("EXCEPTION 2 - #{ ex.message }")
         return false
      end
    end

    def get_service
      connection = faraday.new
      begin
        connection.get do |req|
          req.headers['Authorization'] = "Bearer #{OnlinepayDemo.merchant_key}"
          req.url @api_url, self.args
        end
      rescue StandardError => ex
         rails("EXCEPTION 2 - #{ ex.message }")
         return false
      end

      connection = faraday.new
      begin
        connection.post do |req|
          req.url @api_url
          req.headers['Content-Type'] = 'application/json'
          req.headers['Authorization'] = "Bearer #{OnlinepayDemo.merchant_key}"
          req.body = self.args
        end
      rescue StandardError => ex
         raise("EXCEPTION 2 - #{ ex.message }")
         return false
      end
    end
  end
end
