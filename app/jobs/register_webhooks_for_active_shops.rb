class RegisterWebhooksForActiveShops < ApplicationJob
  queue_as :default

  def perform
    register_webhooks_for_active_shops
  end

  private

  def register_webhooks_for_active_shops
    Shop.find_each do |shop|
      ShopifyApp::WebhooksManagerJob.perform_now(
        shop_domain: shop.shopify_domain,
        shop_token: shop.shopify_token,
        webhooks: ShopifyApp.configuration.webhooks
      )
    end
  end
end
