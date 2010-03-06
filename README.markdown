USAGE
=====

1. rake db:bootstrap
2. set up Paypal Express in admin/payment_methods using your sandbox credentials:
admin > Configuration > Payment Methods > New Payment Method and choose BillingIntegration::PaypalExpress
3. I chose not to check review, to skip the confirm step in the store and opted for Pay Now
