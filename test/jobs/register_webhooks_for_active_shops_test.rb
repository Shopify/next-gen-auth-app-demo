require 'test_helper'

class RegisterWebhooksForActiveShopsTest < ActiveJob::TestCase
  def setup
    @shop_1 = shops(:regular_shop)
    @shop_2 = shops(:second_shop)
  end

  def job
    @job ||= ::RegisterWebhooksForActiveShops.new
  end


  test "RegisterWebhooksForActiveShops registers webhooks for all existing shops" do
    ShopifyApp::WebhooksManagerJob.expects(:perform_now).with(
      shop_domain: @shop_1.shopify_domain,
      shop_token: @shop_1.shopify_token,
      webhooks: ShopifyApp.configuration.webhooks
    ).once

    ShopifyApp::WebhooksManagerJob.expects(:perform_now).with(
      shop_domain: @shop_2.shopify_domain,
      shop_token: @shop_2.shopify_token,
      webhooks: ShopifyApp.configuration.webhooks
    ).once

    job.perform_now
  end
end
