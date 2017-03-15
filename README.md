# Onlinepay_demo

a  simple onlinepay sdk

## Installation

Add this line to your application's Gemfile:

```ruby
gem install onlinepay_demo
```


### Configuration
```ruby
OnlinepayDemo.merchant_key = 'YOUR_KEY'
OnlinepayDemo.env = 'production'     # The default value is'development', which automatically                                        identifies the rack environment。
```

### Payments

```ruby
response = UnionpayOpen::Service.payment(product: 'Your Product',
										 amount: "1000",
                                         currency: 'CND',
										 redirectSuccessUrl: "https://your-site.com/success")
```



### List

```ruby
response = UnionpayOpen::Wap.query_list(date_from: '2016-05-11',
                                         page: "1",
                                         per_page: "1")

response = UnionpayOpen::Wap.query_single(payment_token: '3232323322')
```
### Payment Confirmation
```ruby
response = UnionpayOpen::Wap.payment_confirmation(payment_token: '3232323322')
```

### Payouts

```ruby
response = UnionpayOpen::Wap.payout(amount: '3232323322',
                                    currency: 'CNY',
                                    orderNumber: '2333',
                                    walletToken: 'fefefef',
                                    bankAccount: {
                                    accountHolder: "John Snow",
                                    accountNumber: "11111111111111111",
                                    bankCode: "BOC"
                                    },
                                    billing: {
                                    state: "11",
                                    countryCode: "CHN",
                                    city: "1000"
                                    })
```

### Balance

```ruby
response = UnionpayOpen::Wap.balance(currency: 'CNY')
```
