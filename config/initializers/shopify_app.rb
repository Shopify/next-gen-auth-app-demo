ShopifyApp.configure do |config|
  config.application_name = "App Bridge Authentication Demo App"
  config.api_key = ENV['SHOPIFY_API_KEY']
  config.secret = ENV['SHOPIFY_API_SECRET']
  config.old_secret = ""
  #config.scope = "read_products"
  config.scope = "write_products, write_orders, read_customers, write_content, write_themes, read_product_listings, read_script_tags, read_locations, write_shipping, read_checkouts, write_discounts, write_locales, write_inventory" # Consult this page for more scope options:
  #config.scope = "write_themes, read_product_listings, read_script_tags, read_locations, write_shipping, read_checkouts, write_discounts, write_locales, write_inventory"
  config.user_access_scopes = "write_products"
  #config.scope = "read_products, read_orders"
  #config.scope = "read_products, write_orders"
  #config.scope = "write_orders"
  #config.scope = "write_products, write_orders, read_customers, write_content, write_themes, read_product_listings, read_script_tags, read_locations, write_shipping, read_checkouts, write_discounts, write_locales, write_inventory"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2020-07"
  config.shop_session_repository = 'Shop'
  config.user_session_repository = 'User'
  config.allow_jwt_authentication = true
  config.webhooks = [
    {topic: 'app/uninstalled', address: "#{ENV['APP_URL']}/webhooks/app_uninstalled", format: 'json'},
  ]
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known
