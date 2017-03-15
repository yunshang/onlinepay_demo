require "spec_helper"

RSpec.describe Onlinepay do
  it "has a version number" do
    expect(Onlinepay::VERSION).not_to be nil
  end

  @@merchant_key = 'key'
  @@env = 'development'

  it "merchant_key must" do
    expect {
      Onlinepay::Service.new
    }.to raise_error(Onlinepay::ArgumentError)
  end

  it "can payments" do
    service = Onlinepay::Service.new merchant_key: @@merchant_key, test: true, env: @@env
    expect(
      service.payment(
        product: 'product',
        amount: 2,
        currency: 3,
        redirectSuccessUrl: 'url'
      )
    ).to eq({
      method: :json,
      url: '/api/v1/payments',
      merchant_key: @@merchant_key,
      params: {
        product: 'product',
        amount: 2,
        currency: 3,
        redirectSuccessUrl: 'url'
      }
    })
  end

  it "payments params must" do
    service = Onlinepay::Service.new merchant_key: @@merchant_key, test: true, env: @@env
    expect {
      service.payment(
        product: 'product',
      )
    }.to raise_error(Onlinepay::ArgumentError)
  end

  it "can query_list" do
    service = Onlinepay::Service.new merchant_key: @@merchant_key, test: true, env: @@env
    expect(
      service.query_list(
        date_from: '2016-05-11',
        page:1,
        per_page:1
      )
    ).to eq({
      method: :get,
      url: '/api/v1/payments',
      merchant_key: @@merchant_key,
      params: {
        date_from: '2016-05-11',
        page:1,
        per_page:1
      }
    })
  end
end
