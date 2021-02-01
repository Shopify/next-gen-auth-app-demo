# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorage

  def self.update_merchant_scopes(shop, scopes)
    shop.scopes = scopes
  end

  def self.merchant_scopes(shop)
    shop.scopes
  end

  def uninstall
    destroy
  end

  def uninstall!
    destroy!
  end

  def api_version
    ShopifyApp.configuration.api_version
  end
end
