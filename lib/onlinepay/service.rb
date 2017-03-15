module Onlinepay
  class Service
    ENDPOINT_DEV = 'https://business.sandbox.onlinepay.com'
    ENDPOINT_PRO = 'https://business.onlinepay.com'
    def initialize(merchant_key: nil,test: false, env: 'development')
      @endpoint = ( env == "production" ? ENDPOINT_PRO : ENDPOINT_DEV )
      if merchant_key.nil?
        raise ArgumentError.new('merchant_key is must')
      end
      @merchant_key = merchant_key
      @test = test
      @conn = Faraday.new(@endpoint, :ssl => {:verify => true}) do |faraday|
        faraday.headers['Authorization'] = "Bearer #{@merchant_key}"
      end
    end

    def payment(params)
      self.check_params(params, %i{product amount currency})
      self.request_post_json('/api/v1/payments', params)
    end

    def query_list(params)
      self.request_get_json('/api/v1/payments', params)
    end

    def query_single(params)
      self.request_get_json("/api/v1/payments#{params}", params)
    end

    def payment_confirmation(params)
      self.request_get_json("/api/v1/payments/p/#{params}", params)
    end

    def payout(params)
      self.check_params(params, %i{walletToken amount currency orderNumber bankAccount billing})
      self.request_post_json('/api/v1/payouts', params)
    end

    def balance(params)
      self.check_params(params, %i{ currency })
      self.request_post_json('/api/v1/balance', params)
    end

    def check_params(params, require_params)
      require_params.each do |rp|
        raise ArgumentError.new("#{rp} is must") if not params.has_key?(rp)
      end
    end

    def request_get_json(url, params)
      return {
        method: :get,
        url: url,
        params: params,
        merchant_key: @merchant_key,
      } if @test

      @conn.get do |req|
        req.url = url
        req.params = params
      end
    end

    def request_post_json(url, params)
      return {
        method: :json,
        url: url,
        params: params,
        merchant_key: @merchant_key,
      } if @test

      @conn.post do |req|
        req.url = url
        req.body = params
      end
    end
  end
end
