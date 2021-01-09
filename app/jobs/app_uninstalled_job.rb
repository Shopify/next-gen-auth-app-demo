class AppUninstalledJob < ActiveJob::Base
  def perform(args)
    shop = Shop.find_by(shopify_domain: args[:shop_domain])

    mark_shop_as_uninstalled(shop)
  end

  private

  def mark_shop_as_uninstalled(shop)
    shop.destroy! if shop
  end
end
