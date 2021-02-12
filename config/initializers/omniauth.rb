# frozen_string_literal: true

Rails.application.config.middleware.use(OmniAuth::Builder) do

  def update_shop_scopes?(shop)
    shop_access_scopes = ShopifyApp::SessionRepository.retrieve_shop_access_scopes(shop)
    configuration_scopes = ShopifyApp.configuration.shop_access_scopes
    ShopifyApp::ScopeUtilities.access_scopes_mismatch?(shop_access_scopes, configuration_scopes)
  end

  def scopes(shop)
    if update_shop_scopes?(shop)
      ShopifyApp.configuration.shop_access_scopes
    else
      ShopifyApp.configuration.user_access_scopes
    end
  end

  provider(:shopify,
    ShopifyApp.configuration.api_key,
    ShopifyApp.configuration.secret,
    scope: ShopifyApp.configuration.scope,
    setup: lambda { |env|
      request = Rack::Request.new(env)
      strategy = env['omniauth.strategy']

      shopify_auth_params = strategy.session['shopify.omniauth_params']&.with_indifferent_access
      shop_host = request.params['shop'] || (shopify_auth_params && shopify_auth_params['shop'])
      shop = if shop_host.present?
        "https://#{shopify_auth_params[:shop]}"
      else
        ''
      end

      strategy.options[:client_options][:site] = shop
      strategy.options[:scope] = scopes(shop_host)
      strategy.options[:old_client_secret] = ShopifyApp.configuration.old_secret
      strategy.options[:per_user_permissions] = !update_shop_scopes?(shop_host) && strategy.session[:user_tokens]
    }
  )
end
