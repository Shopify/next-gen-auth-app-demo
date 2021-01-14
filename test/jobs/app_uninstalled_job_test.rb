require 'test_helper'
require 'helpers/shop_lifecycle_test_helper'

class AppUninstalledJobTest < ActiveJob::TestCase
  include ShopLifecycleTestHelper

  def setup
    @shop_1 = shops(:regular_shop)
    @shop_2 = shops(:second_shop)
  end

  def job
    @job ||= ::AppUninstalledJob.new
  end

  test "AppUninstalledJob marks the shop as uninstalled from the app" do
    assert_uninstalls @shop_1.shopify_domain do
      job.perform(shop_domain: @shop_1.shopify_domain)
    end

    assert_installed @shop_2.shopify_domain
  end

  test "AppUninstalledJob does nothing for non-existent shop" do
    assert_no_installation_change do
      job.perform(shop_domain: 'example.myshopify.com')
    end
  end
end
