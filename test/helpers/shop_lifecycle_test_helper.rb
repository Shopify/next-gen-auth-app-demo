module ShopLifecycleTestHelper
  def assert_uninstalls(shopify_domain, &block)
    assert_difference 'Shop.count', -1, "one shop should have been uninstalled", &block

    assert_nil Shop.find_by(shopify_domain: shopify_domain), "shop #{shopify_domain} is still installed"
  end

  def assert_installed(shopify_domain)
    assert_not_nil Shop.find_by(shopify_domain: shopify_domain)
  end

  def assert_no_installation_change
    assert_difference 'Shop.count', 0 do
      yield
    end
  end
end
