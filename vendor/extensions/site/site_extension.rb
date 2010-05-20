# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SiteExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/site"

  # Please use site/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate

    # make your helper avaliable in all views
    # Spree::BaseController.class_eval do
    #   helper YourHelper
    # end
    
    # if you set this to false, you'll have to capture payments in admin/orders/<order_number>/payments 
    AppConfiguration.class_eval do
      preference :auto_capture, :boolean, :default => true
    end
    
    # go from address to payment
    Checkout.state_machines[:state] = StateMachine::Machine.new(Checkout, :initial => 'address') do
      after_transition :to => 'complete', :do => :complete_order
      before_transition :to => 'complete', :do => :process_payment
    
      event :next do
        transition :to => 'payment', :from => 'address'
        transition :to => 'complete', :from => 'payment'
      end
    end
    
    # to have a custom logo appear on paypal, set Spree::Config[:site_url] to a domain you can access
    # and prepare a logo. see :header_image below
    # use https to avoid browser warnings about insecure page content
    Spree::PaypalExpress.class_eval do
      def paypal_site_opts
        { :description             => "Goods from #{Spree::Config[:site_name]}", # site details...

          #:page_style             => "foobar", # merchant account can set named config
          :header_image            => "https://" + Spree::Config[:site_url] + "/images/logo.gif",
          :background_color        => "ffffff",  # must be hex only, six chars
          :header_background_color => "ffffff",
          :header_border_color     => "ffffff",
          :currency                => 'SEK'
        }
      end      
    end
    
    # Retrieve payment method id for instant paypal express checkout
    OrdersController.class_eval do
      edit.before :payment_method
      def payment_method
        @payment_method ||= PaymentMethod.available.select{|p| p.is_a? BillingIntegration::PaypalExpress}.first
      end
    end
    
  end
end
