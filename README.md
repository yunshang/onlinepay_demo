# Onlinepay_demo

a  simple onlinepay sdk

## Before use


```ruby
  bundle
  rake spec  # run spec
```



### Payments

```ruby
 service = Onlinepay::Service.new merchant_key: @@merchant_key, test: true, env: @@env
```

```ruby
service.payment(product: 'Your Product',
                 amount: "1000",
                 currency: 'CND',
                 redirectSuccessUrl: "https://your-site.com/success"
               )
```



### List

```ruby
service.query_list(date_from: '2016-05-11', page: "1", per_page: "1")

service.query_single(payment_token: '3232323322')
```
### Payment Confirmation

```ruby
service.payment_confirmation(payment_token: '3232323322')
```

### Payouts

```ruby
service.payout( amount: '3232323322',
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
                }
              )
```

### Balance

```ruby
service.balance(currency: 'CNY')
```
