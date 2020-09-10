class Session < ApplicationRecord
  include ShopifyApp::ActualSessionStorage

  def api_version
    ShopifyApp.configuration.api_version
  end
end
