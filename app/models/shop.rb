# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorageWithScopes

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
