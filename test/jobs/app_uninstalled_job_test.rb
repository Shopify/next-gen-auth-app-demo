require 'test_helper'

class AppUninstalledJobTest < ActiveJob::TestCase
  def setup
    @shop_1 = shops(:regular_shop)
    @shop_2 = shops(:second_shop)
  end

  def job
    @job ||= ::AppUninstalledJob.new
  end

  test "AppUninstalledJob marks the shop as uninstalled from the app" do
    assert_difference 'Shop.count', -1 do
      job.perform(shop_domain: @shop_1.shopify_domain)
    end

    assert_nil Shop.find_by(shopify_domain: @shop_1.shopify_domain)
    assert_equal @shop_2, Shop.find_by(shopify_domain: @shop_2.shopify_domain)
  end

  test "AppUninstalledJob does nothing for non-existent shop" do
    assert_difference 'Shop.count', 0 do
      job.perform(shop_domain: 'example.myshopify.com')
    end
  end
end
