require 'test_helper'
require 'helpers/shop_lifecycle_test_helper'

class ShopTest < ActiveSupport::TestCase
  include ShopLifecycleTestHelper

  def setup
    @shop_1 = shops(:regular_shop)
    @shop_2 = shops(:second_shop)
  end

  test "#uninstall marks the shop as uninstalled" do
    assert_uninstalls @shop_1.shopify_domain do
      @shop_1.uninstall
    end

    assert_nil Shop.find_by(shopify_domain: @shop_1.shopify_domain)
    assert_equal @shop_2, Shop.find_by(shopify_domain: @shop_2.shopify_domain)
  end

  test "#uninstall! marks the shop as uninstalled" do
    @shop_1.uninstall!

    assert_nil Shop.find_by(shopify_domain: @shop_1.shopify_domain)
    assert_equal @shop_2, Shop.find_by(shopify_domain: @shop_2.shopify_domain)
  end
end
