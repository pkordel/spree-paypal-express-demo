class BillingIntegration::PaypalExpressUk < BillingIntegration
  preference :login, :string
  preference :password, :password
  preference :signature, :string
  preference :review, :boolean, :default => false
  preference :no_shipping, :boolean, :default => true

  def provider_class
    ActiveMerchant::Billing::PaypalExpressUkGateway
  end

end
